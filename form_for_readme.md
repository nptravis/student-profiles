# The form_for helper

This is a great form building method, one of the many ActionView::Helper methods. Ideal for interfacing with RESTful routes, and nested resources. So, a basic example for a sign up form:

```
<%= form_for @user do |f| %>
	raise f.class.inspect
<% end %>

```

Shows us the f is a ActionView:Helper object:

```
ActionView::Helpers::FormBuilder
```