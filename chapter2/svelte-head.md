### `<svelte:head>`

```html
<svelte:head>
```

`<svelte:head>` 让在 `document.head` 中插入元素成为可能。在服务端渲染时，`head` 部分内容单独的暴露给主 `html`。

```html
<svelte:head>
	<link rel="stylesheet" href="tutorial/dark-theme.css">
</svelte:head>
```