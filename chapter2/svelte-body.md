### `<svelte:body>`

```html
<svelte:body on:event={handler}/>
```

与 `<svelte：window>` 一样，此元素允许你在 `document.body` 上添加事件监听，用来监听`mouseenter` 和 `mouseleave` 等等不会在 window 上触发的事件 。
