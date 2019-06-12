### Element bindings

```html
bind:property={variable}
```

```html
bind:group={variable}
```

```html
bind:this={dom_node}
```



数据通常从父级流向子级。`bind:`指令允许数据以另一种方式从子级流向父级。大多数的绑定是绑定在特定的元素。

最简单反映了属性的值的绑定，例如`input.value`。

```html
<input bind:value={name}>
<textarea bind:value={text}></textarea>

<input type="checkbox" bind:checked={yes}>
```

如果，属性值和属性名相同，也可以用简写的方式：

```html
<!-- These are equivalent -->
<input bind:value={value}>
<input bind:value>
```

强制输入的值是数字；即使`input.value`是一个字符串，svelte将把它当作一个数字。如果输入为空或无效（当`type="number"`），则该值为 `undefined`。

```html
<input type="number" bind:value={num}>
<input type="range" bind:value={num}>
```


#### Binding related elements

可以使用 `bind:group` 来让 `input` 一起工作

```html
<script>
	let tortilla = 'Plain';
	let fillings = [];
</script>

<!-- grouped radio inputs are mutually exclusive -->
<input type="radio" bind:group={tortilla} value="Plain">
<input type="radio" bind:group={tortilla} value="Whole wheat">
<input type="radio" bind:group={tortilla} value="Spinach">

<!-- grouped checkbox inputs populate an array -->
<input type="checkbox" bind:group={fillings} value="Rice">
<input type="checkbox" bind:group={fillings} value="Beans">
<input type="checkbox" bind:group={fillings} value="Cheese">
<input type="checkbox" bind:group={fillings} value="Guac (extra)">
```

#### Binding `<select>` value

`<select>`绑定的值，对应的是 selected 的`<option>`上的value属性的值，该值可以是任何值（不仅仅是字符串，可以是 DOM 中出现的值）。

```html
<select bind:value={selected}>
	<option value={a}>a</option>
	<option value={b}>b</option>
	<option value={c}>c</option>
</select>
```

`<select multiple>` 的表现和 `checkbox` 组一样：

```html
<select multiple bind:value={fillings}>
	<option value="Rice">Rice</option>
	<option value="Beans">Beans</option>
	<option value="Cheese">Cheese</option>
	<option value="Guac (extra)">Guac (extra)</option>
</select>
```

当 `<option>` 的`value`，和`<option>` 中的文本内容相同，则 `value ` 属性可以被省略。

```html
<select multiple bind:value={fillings}>
	<option>Rice</option>
	<option>Beans</option>
	<option>Cheese</option>
	<option>Guac (extra)</option>
</select>
```

#### Media element bindings

媒体元素(`audio`和`video`)有自己的一套绑定规则：

四个只读的属性

- `duration`(只读) - video 的总时长，单位是秒
- `buffered`(只读) - 一个`{start, end}`对象数组
- `seekable`(只读) - 同上
- `played`(只读) - 同上

三个可以双向绑定的属性

- currentTime： 当前视频的播放的位置，单位是秒
- paused： 是否是暂停
- volume： 音量，是`0`和`1`之间的值

```html
<video
	src={clip}
	bind:duration
	bind:buffered
	bind:seekable
	bind:played
	bind:currentTime
	bind:paused
	bind:volume
></video>
```

#### Block-level element bindings

块级元素有4个只读的绑定，其值的计算使用的技术方式和[这个](http://www.backalleycoder.com/2013/03/18/cross-browser-event-based-element-resize-detection/)类似：

- clientWidth
- `clientHeight`
- `offsetWidth`
- `offsetHeight`



```html
<div
	bind:offsetWidth={width}
	bind:offsetHeight={height}
>
	<Chart {width} {height}/>
</div>

```



#### Binding a DOM node

要获取一个 DOM 节点的引用，可以使用`bind:this`

```HTML
<script>
	import { onMount } from 'svelte';

	let canvasElement;

	onMount(() => {
		const ctx = canvasElement.getContext('2d');
		drawStuff(ctx);
	});
</script>

<canvas bind:this={canvasElement}></canvas>
```
