### in:<font color=#9595a0>*fn*</font>/out:<font color=#9595a0>*fn*</font>
```
in:fn
```
```
in:fn={params}
```
```
in:fn|local
```
```
in:fn|local={params}
```
```
out:fn
```
```
out:fn={params}
```
```
out:fn|local
```
```
out:fn|local={params}
```
和`transition`类似，但是只适用于元素和进入（`in:`）和元素的离开（`out:`）。

```js
{#if visible}
	<div in:fly out:fade>
		flies in, fades out
	</div>
{/if}
```

和`transition`不一样的是，transitions 带有`in: ` 或 `out:` 指令就不是双向的。进入的过渡执行的过程中，切换至离开动画，进入动画会继续执行，且与离开动画并存。如果之前离开的动画还未执行完成，会重新开启离开的动画。