### 条件渲染 (If blocks)

```html
{#if expression}...{/if}

{#if expression}...{:else if expression}...{/if}

{#if expression}...{:else}...{/if}
```

条件渲染的内容，可以被包裹在 一个 `if ` 块中。

```html
{#if answer === 42}
	<p>what was the question?</p>
{/if}
```

附加条件可以用`{:else if expression}`，也可以选择以`{:else}`结尾。

```html
{#if porridge.temperature > 100}
	<p>too hot!</p>
{:else if 80 > porridge.temperature}
	<p>too cold!</p>
{:else}
	<p>just right!</p>
{/if}
```

