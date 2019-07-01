### HTML expressions

```html
{@html expression}
```

在文本表达式中，像`<`和`>`这样的字符被转义。而在 HTML 表达式中，不会被转义。

> Svelte 不会在注入 HTML 之前过滤表达式。所以，如果是不受信任源的数据，你必须先过滤它。否则，你的用户将会面临 XSS 攻击。

```html
<div class="blog-post">
	<h1>{post.title}</h1>
	{@html post.content}
</div>
```

