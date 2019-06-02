### HTML表达式(HTML expressions)

```html
{@html expression}
```

在文本表达式中，像`<`和`>`这样的字符被转义。而在`HTML表达式` 中，讲不会被转义。

> svelte不会在注入HTML之前，过滤表达式。如果数据是来自不可信的地方，你必须过滤它。否则，你的用户将会面临XSS攻击的危险。

```html
<div class="blog-post">
	<h1>{post.title}</h1>
	{@html post.content}
</div>
```

