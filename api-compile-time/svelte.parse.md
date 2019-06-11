### svelte.parse

```js
ast: object = svelte.parse(
	source: string,
	options?: {
		filename?: string,
		customElement?: boolean
	}
)
```

`parse` 函数用来解析一个组件并返回它的抽象语法树。

```js
const svelte = require('svelte/compiler');

const ast = svelte.parse(source, { filename: 'App.svelte' });
```

与编译用的 `generate: false` 选项不同的是，这个只会进行解析，不会做对这个组件做更多的验证或分析。