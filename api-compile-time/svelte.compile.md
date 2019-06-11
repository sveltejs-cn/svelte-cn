### svelte.compile

```
result: {
	js,
	css,
	ast,
	warnings,
	vars,
	stats
} = svelte.compile(source: string, options?: {...})

```

这里就是魔法发生的地方。`svelte.compile` 把你的组件源代码进行了转换，变成了一个导出一个 class 的 JavaScript 模块。

```js
const svelte = require('svelte/compiler');

const result = svelte.compile(source, {
	// options
});
```

下面这些选项可以被传递给编译器，这些参数都是非必需传入的。

Options | default | description
-- | -- | --
filename | null | string 用于调试信息和 sourcemaps。你的打包插件会自动设置这个选项。
name | "Component" | string 这个用来设置最终生成的 JavaScript class 的 name（但是如果它与作用域内的其他变量冲突，编译器会重新命名它）。这个通常会通过 filename 来进行推断。
formate | "esm" | 该参数如果是 "esm" 则创建一个 JavaScript 模块（采用的语法是 import 和 export）。该参数如果是 "cjs" 则创建一个 CommonJS 模块（采用的语法是 require 和 module.exports），这对于服务端渲染或者测试会比较有用。
generate | "dom" | 该参数如果是 "dom"，Svelte 会生成一个 JavaScript class 用于挂载到 DOM 上。如果是 "ssr"，Svelte 会生成一个适用于服务端渲染的带有 render 方法的对象。该参数如果是 false，不会返回任何 JavaScript 或 CSS，只会返回元数据。
dev | false | 如果为 true，则会增加一些额外的代码，用来在运行时进行检查和在开发时提供调试信息。
immutable | false | 如果为 true，告诉编译器你将不会修改任何对象。这允许你在检查变量值是否变化这件事上更加不保守。
hydratable | false | 如果为 true，启用 hydrate: true 运行时选项，这将允许一个组件复用已经存在的 DOM 而不是从头新创建一个。
legacy | false | 如果为 true，生成的代码可以兼容 IE9 和 IE10，但是会不支持例如 element.dataset 之类的东西。
accessors | false | 如果为 true，组件的 props 将会创建 getters 和 setters。如果为 false，它们只会为被导出的只读变量创建（即那些以 const，class 和 function 声明的变量）。如果编译时 customElement 为 true，那么这个选项默认是 true。
customElement | false | 如果为 true，告诉编译器生成一个自定义的原生 element 的构造器而不是常规的 Svelte 组件。
tag | null | 该参数类型为 string,  用来告诉 Svelte 用什么 tag name 来注册自定义 element。它必须是以小写的字母或数字组成的字符串，并至少包含一个连字符，例如 my-element。
css | true | 如果为 true，JavaScript class 中将会包含 styles 并在运行时注入。建议把它设置为 false，使用静态生成的 CSS，这样的话 JavaScript bundles 会更小并且性能更好。
preserveComments | false | 如果该值为 true，在服务端渲染时， HTML 中注释会被保留。默认该值为false, 这些注释会被去掉。
preserveWhitespace | false | 如果该值为 true，在 element 内部或者 element 之间的空格会按照你输入的样子保留，否则就会被 Svelte 优化掉。
outputFilename | null | 该参数类型为 string,用于生成 JavaScript 的sourcemap
cssOutputFilename | null | 该参数类型为 string,用于生成 CSS 的sourcemap
sveltePath | "svelte" | svelte package 所在的位置。任何来自 svelte 或者 svelte/[module] 的 import 会根据它进行修改。                                                                            |

返回的 `result` 对象包含了与你组件相关的代码以及一些有用的元数据。

```js
const {
	js,
	css,
	ast,
	warnings,
	vars,
	stats
} = svelte.compile(source);
```

- `js` 和 `css` 包含了以下属性：
    - `code` 是一个 JavaScript 字符串
    - `map` 是一个 sourcemap，额外带有两个方便的方法 `toString()` 和 `toUrl()`
- `ast` 是一个抽象语法树，代表了你组件的结构。
- `warnings` 是在编译时产生的一个包含了若干 warning 对象的数组。每个 warning 包含了几个属性：
    - `code` 是用来区别 warning 类型的字符串
    - `message` 使用了人类可读的术语来描述具体的问题。
    - `start` 和 `end`，如果 warning 与具体的（代码）位置相关，这两个属性是包含了 `line`，`column` 和 `character` 属性的对象。
    - `frame`，如果适用的话，是一个用行号来高亮非法代码的字符串。
- `vars` 是一个包含了组件声明的数组，例如在 [eslint-plugin-svelte3](https://github.com/sveltejs/eslint-plugin-svelte3) 中被用到。每个变量包含以下几个属性：
    - `name` 就不解释了
    - `export_name` 是导出时这个变量的名字（一般来说就是 `name` 除非你用了 `export...as`）
    - `injected`，如果这个组件声明是 Svelte 注入的就是 `true`，如果是你自己写的就是 `false`
    - `module`，如果这个值是在 `context="module"` 脚本下声明的就是 `true`
    - `mutated`，如果将值的属性分配给组件内部，则为 `true`
    - `reassigned`，如果值在组件内部重新赋值，则为 `true`
    - `referenced`，如果值在组件外部被使用，则为 `true`
    - `writable`，如果值是以 `let` 或 `var` 声明的（不能是 `const`，`class` 或 `function`）则为 `true`
- `stats` 是一个对象，用来给 Svelte 开发团队用来诊断编译器的。避免依赖它保持不变。