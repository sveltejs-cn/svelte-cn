```javascript
const result = Component.render(...)
```

与客户端组件不同，服务器端组件在渲染后没有生命周期 。他们的全部工作是创建一些HTML和CSS。出于这个原因，API有些不同。

服务器端组件暴露了一个`render`方法，该`render` 方法接收可选的`props`, 同时该 `render` 方法返回一个带有`head`，`html`和`css`属性的对象，其中head包含遇到的任何<svelte：head>元素的内容。

```javascript
const App = require('./App.svelte');

const { head, html, css } = App.render({
	answer: 42
});
```



