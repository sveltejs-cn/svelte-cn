### Await

```html
{#await expression}...{:then name}...{:catch name}...{/await}
```
```html
{#await expression}...{:then name}...{/await}
```
```html
{#await expression then name}...{/await}
```

`await` 可以让你分支处理 Promise 的三种状态 `pending`, `fulfilled`, `rejected`

```html
{#await promise}
	<!-- promise is pending -->
	<p>waiting for the promise to resolve...</p>
{:then value}
	<!-- promise was fulfilled -->
	<p>The value is {value}</p>
{:catch error}
	<!-- promise was rejected -->
	<p>Something went wrong: {error.message}</p>
{/await}
```

如果在 Promise `reject`时不需要渲染任何东西（或者不会出现错误），则可以省略 catch 块。

```html
{#await promise}
	<!-- promise is pending -->
	<p>waiting for the promise to resolve...</p>
{:then value}
	<!-- promise was fulfilled -->
	<p>The value is {value}</p>
{/await}
```
如果你不关心`pending`状态，也可以省略初始化的状态。

```html
{#await promise then value}
	<p>The value is {value}</p>
{/await}
```

