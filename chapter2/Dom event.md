### DOM 事件 (DOM events)

```html
on:eventname={handler}

on:eventname|modifiers={handler}
```

你可以使用 `on:`的写法可以监听DOM 事件：

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

事件回调函数不会影响性能，会以内联的方式的声明。与属性一样，为了语法高亮，`指令`的值可以被`引号` 包裹。

```html
<button on:click="{() => count += 1}">
	count: {count}
</button>
```

使用 `|` 字符来向DOM事件添加修饰符。

下面的修饰符都是可用的：

- preventDefault： 在 handeler 被调用前，调用 `event.preventDefault()`
- stopPropagation: 阻止事件冒泡
- passive： 提高触摸/滚动事件的滚动性能
- capture：在捕获阶段而不是冒泡阶段，触发事件处理函数
- once: 事件处理函数只会被执一次。

修饰符可以使用 `|` 链接起来：`on:click|once|capture={...}`

```html
<form on:submit|preventDefault={handleSubmit}>
	<!-- the `submit` event's default is prevented,
		 so the page won't reload -->
</form>
```

如果 `on:` 指令，后面没有指定事件回调函数。意味着，这个组件的消费者，将会监听这个事件。

```html
<button on:click>
	The component itself will emit the click event
</button>
```

对于同样的事件，绑定多个事件处理函数，也可以。

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

## 