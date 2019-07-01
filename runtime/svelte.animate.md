### svelte/animate

`svelte/animate` 模块导出一个用于 svelte 动画的函数。

#### <p id="flip">filp</p>

```
animate:flip={params}
```
`flip` 函数计算元素的开始和结束位置，并通过转换`x`、`y`坐标对他们设置动画。`flip` 主张的是[First，Last，Invert，Play](https://aerotwist.com/blog/flip-your-animations/)。

`flip` 接受下面这些参数：
- `delay` (`number`，默认 0) - 开始前的毫秒数
- `duration` (`number`|`function`, 默认 `d => Math.sqrt(d) * 120`) - 参见下文
- `easing` (`function`, `cubicOut`) - 缓动函数
`duration`可以通过下面任一形式定义：
- 一个`number`，以毫秒为单位
- 一个函数，`distance: number => duration: number`，接受`distance`的元素将以像素为单位进行移动，并以毫秒为单位返回持续的时间。支持指定相对于每个元素移动的持续时间。

```html
<script>
	import { flip } from 'svelte/animate';
	import { quintOut } from 'svelte/easing';

	let list = [1, 2, 3];
</script>

{#each list as n (n)}
	<div animate:flip="{{delay: 250, duration: 250, easing: quintOut}}">
		{n}
	</div>
{/each}
```

你可以在 [animate tutorial](https://svelte.dev/tutorial/animate) 看到完整的示例。