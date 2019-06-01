```js
result: {
	code: string,
	dependencies: Array<string>
} = svelte.preprocess(
	source: string,
	preprocessors: Array<{
		markup?: (input: { source: string, filename: string }) => Promise<{
			code: string,
			dependencies?: Array<string>
		}>,
		script?: (input: { source: string, attributes: Record<string, string>, filename: string }) => Promise<{
			code: string,
			dependencies?: Array<string>
		}>,
		style?: (input: { source: string, attributes: Record<string, string>, filename: string }) => Promise<{
			code: string,
			dependencies?: Array<string>
		}>
	}>,
	options?: {
		filename?: string
	}
)
```

preprocess 函数提供了一个方便的钩子用于任意地转换组件源代码。比如，你可以用它来把 &lt;style lang="sass"&gt; 里的内容转换为普通的 CSS。

```js
const svelte = require('svelte/compiler');

const { code } = svelte.preprocess(source, {
	markup: ({ content, filename }) => {
		return {
			code: content.replace(/foo/g, 'bar')
		};
	}
}, {
	filename: 'App.svelte'
});
```

函数的第一个参数是组件源代码。第二个参数是一个由预处理器（preprocessor）组成的数组（如果你只有一个预处理器，直接传入一个预处理器也可以）。预处理器是一个对象，包含三个可选的方法，分别是 markup，script 以及 style。

markup，script 或 style 函数必须返回一个对象（或者是一个 Promise，resolve 时传入这个对象），这个对象必须有 code 属性和一个可选的 dependencies 属性，其中 code 属性代表了被转换后的源代码。

markup 方法接收整个组件源文本（component source text），以及如果在 preprocess 第三个参数 options 中有被指定 filename 的话，还会有这个 filename。

> 预处理器函数可以额外返回一个名为 map 的对象，包含两个属性 code 和 dependencies，它代表了转换过程的 sourcemap。在现有的 Svelte 版本里它会被忽略，但是在未来的版本中它会被考虑到。

```js
const svelte = require('svelte/compiler');
const sass = require('node-sass');
const { dirname } = require('path');

const { code, dependencies } = svelte.preprocess(source, {
	style: async ({ content, attributes, filename }) => {
		// only process <style lang="sass">
		if (attributes.lang !== 'sass') return;

		const { css, stats } = await new Promise((resolve, reject) => sass.render({
			file: filename,
			data: content,
			includePaths: [
				dirname(filename),
			],
		}, (err, result) => {
			if (err) reject(err);
			else resolve(result);
		}));

		return {
			code: css.toString(),
			dependencies: stats.includedFiles
		};
	}
}, {
	filename: 'App.svelte'
});
```

script 和 style 函数分别接收了 &lt;script&gt; 和 &lt;style&gt; 元素里面的内容。除了 filename 之外，它们还会有一个包含元素属性的对象。

如果 dependencies 数组被返回，那么它会被包含在 result 对象中。这个是给像 rollup-plugin-svelte 这样的包用来监视文件变动的，例如像是在你的 &lt;style&gt; 里有一个 @import 的情况。

```js
const svelte = require('svelte/compiler');

const { code } = svelte.preprocess(source, [
	{
		markup: () => {
			console.log('this runs first');
		},
		script: () => {
			console.log('this runs third');
		},
		style: () => {
			console.log('this runs fifth');
		}
	},
	{
		markup: () => {
			console.log('this runs second');
		},
		script: () => {
			console.log('this runs fourth');
		},
		style: () => {
			console.log('this runs sixth');
		}
	}
], {
	filename: 'App.svelte'
});
```

多个预处理器可以被一起使用。第一个预处理器的输出将会变成第二个的输入。markup 函数最先执行，接着是 script 和 style。