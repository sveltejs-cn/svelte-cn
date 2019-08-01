### svelte/store

`svelte/store` 模块导出的函数是用于创建 `stores`。

#### <p id="writable">writable</p>

```js
store = writable(value: any)
```

```js
store = writable(value: any, (set: (value: any) => void) => () => void)
```

`writable` 函数创建的store，其值可以被外部组件设置。函数会生成一个带有`set`和`update`函数的对象。

`set` 函数需要一个参数，即将要赋值的值。如果 store 的值不等于传入的值，那store的值会设置成该值。

`update` 函数需要一个回调函数作为参数。回调函数以当前 store 的值作为参数，且函数的返回值会赋值给 store。

```js
import { writable } from 'svelte/store';

const count = writable(0);

count.subscribe(value => {
	console.log(value);
}); // logs '0'

count.set(1); // logs '1'

count.update(n => n + 1); // logs '2'
```

如果 `writable` 函数传入了第二个参数，当订阅者数量从0变化到1的时候（而不是从1到2，或其他），它会被调用。这个函数会传递一个修改 store 的 `set` 函数作为参数。且必须返回一个终止函数，它会在订阅者的数量从1变到0的时候被调用。

```js
import { writable } from 'svelte/store';

const count = writable(0, () => {
	console.log('got a subscriber');
	return () => console.log('no more subscribers');
});

count.set(1); // does nothing

const unsubscribe = count.subscribe(value => {
	console.log(value);
}); // logs 'got a subscriber', then '1'

unsubscribe(); // logs 'no more subscribers'
```


#### <p id="readable">readable</p>

```js
store = readable(value: any, (set: (value: any) => void) => () => void)
```

通过 `readable` 创建的store, 其值不可从外部进行设置。第一个参数就是store的初始值。

`readable` 的第二个参数和 `writable` 的第二个参数一样，除了这个参数对于 `writable` 是必须参数以外（否则将无法更新 store 的值）。

```js
import { readable } from 'svelte/store';

const time = readable(new Date(), set => {
	const interval = setInterval(() => {
		set(new Date());
	}, 1000);

	return () => clearInterval(interval);
});
```


#### <p id="derived">derived</p>

```js
store = derived(a, callback: (a: any) => any)
```

```js
store = derived(a, callback: (a: any, set: (value: any) => void) => void | () => void, initial_value: any)
```

```js
store = derived([a, ...b], callback: ([a: any, ...b: any[]]) => any)
```

```js
store = derived([a, ...b], callback: ([a: any, ...b: any[]], set: (value: any) => void) => void | () => void, initial_value: any)
```

`derived` 的 store 可以是从一个或多个 store 中派生。只要这些依赖项发生改变，回调函数就会执行。

最简单的版本，`derived` 仅传入单个store，且回调函数返回一个 `derived` 的值。

```js
import { derived } from 'svelte/store';

const doubled = derived(a, $a => $a * 2);
```

回调函数可以通过接收第二个参数（`set`）异步的方式设值，`set` 函数会在适当的时候调用。

在这个例子中，你还可以传入第三个参数给 `derived` - 在 `set` 函数调用之前 store 的初始值 。

```js
import { derived } from 'svelte/store';

const delayed = derived(a, ($a, set) => {
	setTimeout(() => set($a), 1000);
}, 'one moment...');
```

如果回调函数返回的是一个函数，它将在a）回调再次运行时调用，或者b）最后一个订阅者取消订阅时调用。

```js
import { derived } from 'svelte/store';

const tick = derived(frequency, ($frequency, set) => {
	const interval = setInterval(() => {
	  set(Date.now());
	}, 1000 / $frequency);

	return () => {
		clearInterval(interval);
	};
}, 'one moment...');
```

在这两种情况下，参数数组都可以作为第一个参数而不是单个 store 传递。

```js
import { derived } from 'svelte/store';

const summed = derived([a, b], ([$a, $b]) => $a + $b);

const delayed = derived([a, b], ([$a, $b], set) => {
	setTimeout(() => set($a + $b), 1000);
});
```

#### <p id="get">get</p>

```js
value: any = get(store)
```

一般情况下，你应该通过订阅来读取 store 的值，使用的是随时间变化的值。有时，你可能需要查看你未订阅的 store 的值， `get` 就支持这样做。

```js
import { get } from 'svelte/store';

const value = get(store);
```
