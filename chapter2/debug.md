### @debug

```html
{@debug}
```

```html
{@debug var1, var2, ..., varN}
```

`{@debug ...}`可以替代`console.log(...)`。每当特定值在修改的时候，它会记录下来，而且如果你的devtools打开的状态下，会阻断代码的执行。

```html
<script>
	let user = {
		firstname: 'Ada',
		lastname: 'Lovelace'
	};
</script>

{@debug user}

<h1>Hello {user.firstname}!</h1>
```

它接受以逗号分隔的变量名称列表（不是任意表达式）。

```html
<!-- Compiles -->
{@debug user}
{@debug user1, user2, user3}

<!-- WON'T compile -->
{@debug user.firstname}
{@debug myArray[0]}
{@debug !isReady}
{@debug typeof user === 'object'}
```

不带任何参数的`{@debug}`将插入一个`debugger`，当任何状态发生改变的时候都会触发，而不是特定的值。