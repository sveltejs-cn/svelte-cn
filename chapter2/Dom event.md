### DOM events

```html
on:eventname={handler}
```

```html
on:eventname|modifiers={handler}
```

你可以使用`on:`的指令来监听 DOM 事件：

```html
<script>
	let count = 0;

	function handleClick(event) {
		count += 1;
	}
</script>

<button on:click={handleClick}>
	count: {count}
</button>
```
内联方式声明的处理函数，并不会影响性能。与其他属性一样，为了可以语法高亮显示，指令的值可以用引号包裹。
```html
<button on:click="{() => count += 1}">
	count: {count}
</button>
```

使用 | 字符来向DOM事件添加修饰符。

可以使用以下修饰符：

- `preventDefault`： 在 handeler 执行前，调用 `event.preventDefault()`
- `stopPropagation`: 调用`event.stopPropagation()`，阻止事件冒泡
- `passive`： 提高触摸/滚动事件的滚动性能（ Svelte 会在支持地方默认使用它）
- `capture`：在捕获阶段而不是冒泡阶段，触发事件处理函数
- `once`: 事件处理函数被执一次后会被移除

修饰符可以使用 `|` 链接起来：`on:click|once|capture={...}`

```html
<form on:submit|preventDefault={handleSubmit}>
	<!-- the `submit` event's default is prevented,
		 so the page won't reload -->
</form>
```

如果 `on:` 指令没有值，则组件会转发这个事件，意味着组件的使用者，可以监听这个事件。

```html
<button on:click>
	The component itself will emit the click event
</button>
```

对于同样的事件，可以有多个事件监听者。

```html
<script>
	let counter = 0;
	function increment() {
		counter = counter + 1;
	}

	function track(event) {
		trackEvent(event)
	}
</script>

<button on:click={increment} on:click={track}>Click me!</button>
```