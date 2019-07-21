### `<svelte:window>`

```html
<svelte:window on:event={handler}/>
```
```html
<svelte:window bind:prop={value}/>
```

`<svelte：window>` 可以给 `window` 对象添加事件监听，通过这种方式组件被移除时你不需要再手动移除监听器，服务端渲染时你也不需要手动检测 `window` 对象。

```html
<script>
	function handleKeydown(event) {
		alert(`pressed the ${event.key} key`);
	}
</script>

<svelte:window on:keydown={handleKeydown}/>
```
你也可以绑定以下这些属性：

- `innerWidth`
- `innerHeight`
- `outerWidth`
- `outerHeight`
- `scrollX`
- `scrollY`
- `online` - `window.navigator.onLine`的别名

```html
<svelte:window bind:scrollY={y}/>
```

除 `scrollX` 和 `scrollY` 之外其余都是只读的。