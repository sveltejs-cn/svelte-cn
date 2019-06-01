### `<svelte:window>`

```html
<svelte:window on:event={handler}/>
```
```html
<svelte:window bind:prop={value}/>
```

`<svelte：window>` 支持以这种形式给 `window` 对象添加事件监听，而且不用关心当组件组件的移除或服务端渲染时对于是否存在 `window` 对象检测。

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
> 除 `scrollX` 和 `scrollY` 之外其余都是只读的。