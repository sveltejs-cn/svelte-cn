### 元素绑定（Element bindings）

```html
bind:property={variable}

bind:group={variable}

bind:this={dom_node}
```

数据通常从父级流向子级。`bind:`指令允许数据以另一种方式从子级流到父级。

大多数的绑定，都需要指定特定元素。

最简单的绑定一个属性的值，比如说，`input.value`

```html
<input bind:value={name}>
<textarea bind:value={text}></textarea>

<input type="checkbox" bind:checked={yes}>
```

如果，属性值和属性名相同，也可以使用如下的写法：

```html
<!-- These are equivalent -->
<input bind:value={value}>
<input bind:value>
```

数值输入值是强制的；即使`input.value`是一个字符串，svelte将把它当作一个数字。如果输入为空或无效（在`type=“number”`的情况下），则该值为 `undefined`。

```html
<input type="number" bind:value={num}>
<input type="range" bind:value={num}>
```



#### 绑定相关元素

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

#### 绑定 `<select>` 值

`<select>` 标签上的值，和被选择的`<option>` 标签的 `value` 属性有绑定关系， `value` 属性可以是任何值，而不仅仅是字符串

```html
<select bind:value={selected}>
	<option value={a}>a</option>
	<option value={b}>b</option>
	<option value={c}>c</option>
</select>
```

`<select multiple>` 标签，和 `checkbox` 组类似：

```html
<select multiple bind:value={fillings}>
	<option value="Rice">Rice</option>
	<option value="Beans">Beans</option>
	<option value="Cheese">Cheese</option>
	<option value="Guac (extra)">Guac (extra)</option>
</select>
```

当 `<option>` 标签`value`属性的值，和`<option>` 中的文本内容相同，则 `value ` 属性可以呗省略。

#### 绑定媒体元素

类似于 `audio` 和 `video` 等媒体元素，他们有自己的一套绑定规则。

四个只读的属性

- duration : video 播放的总长度，单位是秒
- buffered
- seekable
- played

还有三个可以双向绑定的属性

- currentTime： 当前视频的播放点
- paused： 是否是暂停
- volume： 音量，在 0和 1 之间

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

#### 绑定块级元素

块级 元素有4个只读的绑定：

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



#### 绑定DOM节点

使用 `bind:this` ，可以创建一个到DOM节点的引用

```php+HTML
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

