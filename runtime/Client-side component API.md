### Creating a component

```javascript
const component = new Component(options)
```

**客户端组件** （ client-side component ）是使用`generate：'dom'` 参数编译的组件（或未指定的generate选项），其是一个JavaScript类。

```javascript
import App from './App.svelte';

const app = new App({
	target: document.body,
	props: {
		// assuming App.svelte contains something like
		// `export let answer`:
		answer: 42
	}
});
```

可以提供以下初始化选项：

| option    | default  | description                                                 |
| :-------- | :------- | :---------------------------------------------------------- |
| `target`  | **none** | 必传。组件挂载的一个`HTMLElement` 对象。                    |
| `anchor`  | `null`   | `target` 的一个子节点，我们的组件将会被插入到该节点的前面。 |
| `props`   | `{}`     | 要提供给组件的属性对象                                      |
| `hydrate` | `false`  | 见下方                                                      |
| `intro`   | `false`  | 如果为true，将在初始渲染时转换，而不是等待后续状态更改      |

`target` 节点中，那些已经存在的子节点，将会保持其原有的位置。

`hydrate`选项会让`Svelte `更新现有DOM（通常来自服务器端渲染）而不是创建新元素。它只有在使用`hydratable：true`选项编译组件时才有效。

尽管上面提到，`target` 节点中，那些已经存在的子节点，将会保持其原有的位置。但是 `hydratable：true`选项会让所有的子节点都被删除，所以 `anchor` 的选项不能和 `hydrate: true` 一起使用。

现存的DOM节点不必匹配上组件，因为 svelted会修复DOM节点。

```javascript
import App from './App.svelte';

const app = new App({
	target: document.querySelector('#server-rendered-html'),
	hydrate: true
});
```



### `$set`

```javascript
component.$set(props)
```

显式的在实例上设置 `props`。 在` <script> ` 标签内，`component.$set({ x: 1 })` 和 `x = 1` 的两个写法作用一致。

调用此方法会在下一个微任务调度更新，这是因为 DOM不会同步更新。

```javascript
component.$set({ answer: 42 });
```

### `$on`

```javascript
component.$on(event, callback)
```

每当组件派发事件时，都会调用对应的回调函数。

该方法返回一个函数，该函数将在调用时删除事件侦听器。

```javascript
const off = app.$on('selected', event => {
	console.log(event.detail.selection);
});

off();
```

### `$destroy`

```javascript
component.$destroy()
```

从DOM中删除组件, 并触发任何`onDestroy` 回调函数。

### Component props

```
component.prop
```

```javascript
component.prop = value
```

如果组件使用` accessors: true ` 编译，则每个实例都将具有与组件的`props`相对应的`getter`和`setter`。

手动设置值将导致`同步`更新，而`component.$set（...）` 方法默认是异步更新。

 默认情况下，`accessors`为false，除非您将其编译为自定义元素。

```javascript
console.log(app.count);
app.count += 1;
```

