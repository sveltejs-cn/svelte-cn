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

`await` 可以让你处理 Promise 的三种状态 `pending`, `fulfilled`, `rejected`

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

如果`Promise`状态变为`reject`，或者发生错误时，你不需要渲染任何东西，则`catch` 块可以被忽略。

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

