### `<svelte:self>`

`<svelte:self>` 元素允许递归的方式包含自身。

`<svelte:self>` 不能出现在标签的最外层，它必须是在 `if` 或 `each` 代码块中，防止陷入无限循环。


```html
<script>
	export let count;
</script>

{#if count > 0}
	<p>counting down... {count}</p>
	<svelte:self count="{count - 1}"/>
{:else}
	<p>lift-off!</p>
{/if}
```