### svelte/register

在 Node.js 中渲染 `Svelte` 组件无需绑定值，使用 `require('svelte/register')`即可。之后，你可以使用 `require` 来引入任何 `.svelte` 文件。

```js
require('svelte/register');

const App = require('./App.svelte').default;

...

const { html, css, head } = App.render({ answer: 42 });
```

> `.default` 是必要的，因为我们是从原生 JavaScript 模块转换为 Node 识别的 CommonJS 模块。请注意，如果你的组件导入 JavaScript 模块，它们将无法在 Node 中加载，你得需要使用打包插件。


如果要设置编译选项或者使用自定义文件扩展名，可函数式调用 `register` 钩子函数来设置。

```js
require('svelte/register')({
  extensions: ['.customextension'], // defaults to ['.html', '.svelte']
	preserveComments: true
});
```