---
title: Hello World
description: The first blog post.
header: Hello World!
duration: 1 minute read
---

&nbsp;

Hello,

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ultricies lacinia euismod. Morbi id enim sapien. Quisque quis imperdiet quam, vitae consequat nunc. Nunc ultricies gravida urna et semper. Quisque vehicula aliquam magna, a finibus quam eleifend vitae. Suspendisse tristique est malesuada, auctor odio eu, feugiat nulla. Aliquam rhoncus mi vitae mi euismod vehicula. Vestibulum malesuada gravida ipsum eu imperdiet. Cras suscipit eleifend lectus id interdum. Nunc tristique porta enim, ultricies vulputate metus pulvinar eget.

Integer dictum sit amet nulla at aliquet. Nam auctor, mi in aliquam porttitor, risus arcu vulputate ex, tempus lobortis diam urna quis purus. Etiam neque diam, vulputate in convallis eget, vehicula at sapien. Vivamus quis arcu et orci ultrices rhoncus. Morbi consequat nunc malesuada nulla facilisis tempor. Vestibulum elementum orci id feugiat porttitor. Sed ornare dui at tellus mattis, nec placerat dolor rutrum. Nullam interdum cursus libero, quis consequat elit venenatis porta. Donec consectetur consectetur magna, at ornare massa pellentesque vel. Aliquam luctus, ante vel venenatis cursus, neque mi venenatis justo, at mollis erat nisl in arcu. Ut rutrum nulla et nibh bibendum, eget consequat dui ultrices. Mauris non dignissim ligula, ac volutpat lorem.


&nbsp;

This is a sample citation:

> Sell yourself, and your subject will exert its own appeal. Believe in your own identity and your own opinions. Writing is an act of ego, and you might as well admit it. Use its energy to keep yourself going -- **William Zinsser, On Writing Well**.

&nbsp;

---

&nbsp;

This is a sample image:

<img src="img/tp-header.png" />

&nbsp;

---

&nbsp;

This is a sample table:

<table>
  <td>
    TOPIC CLUSTERS
  </td>
  <td>
    SAMPLE PHRASES
  </td>
  <tr class="fc-light">
    <td>Overall</td>
    <td><i>"the product was great", "did the job"</i> ...</td>
  </tr>
  <tr class="fc-light">
    <td>Marketplace / Delivery &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td><i>"was delivered on time", "doorstep delivery"</i> ...</td>
  </tr>
  <tr>
    <td>Paper Quality</td>
    <td><i>"strong", "durable", "doesn't tear"</i> ...</td>
  </tr>
  <tr>
    <td>Comfort</td>
    <td><i>"soft", "cushy", "softest TP out there", "little ruff on the bum"</i> ...</td>
  </tr>
  <tr class="fc-light">
    <td>Travel</td>
    <td><i>"carry in your purse or pocket", "great for travel"</i> ...</td>
  </tr>
  <tr class="fc-light">
    <td>Perfumed TPs</td>
    <td><i>"smell is so strong", "smell soooooo good"</i> ...</td>
  </tr>
</table>

&nbsp;

------

&nbsp;

This is a sample list:

* Unverified reviews - These are reviews by people who have not bought the product from the marketplace. Since there is no evidence that these buyers are genuine, we do not consider them.
* Old reviews - Consumer expectations and products change over time. Keeping this in mind, we remove reviews that are more than a couple of years old.
* Review spam - many brands and sellers create "fake" reviews or incentivize reviewers by giving away free samples of their products. This results in significant biases creeping into the review data of a product. We can mitigate this using outlier detection on the reviewer history to identify products that have significant spammy reviews.
* Product variants - Some websites like Amazon group reviews of a bunch of products into the same listing - thankfully, Amazon does provide a (somewhat hidden - "show only this format") option to filter the reviews by variant.
* Too few reviews - it is difficult to draw meaningful conclusions based on a small number of reviews, hence for this blog post, we discard products with fewer than 200 reviews.

&nbsp;
