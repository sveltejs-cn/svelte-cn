### `<svelte:head>`

```html
<svelte:head>
```

`<svelte:head>` 可以让你在 `document.head` 中插入元素。在服务端渲染时，`head` 部分内容单独地暴露给主 `html`。

```html
<svelte:head>
	<link rel="stylesheet" href="tutorial/dark-theme.css">
</svelte:head>
```