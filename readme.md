
I have migrated my wordpress to the other domain, and decided to do that by downloading and uploading the xml file, not by using the old database.
Several days later, when I already have updated new instance, I have noticed, that old posts, that contain ``[gallery]`` inside them, do not show pictures.

Well, I started exploring old and new databases, and found that there are "post" records in wp_posts table for each photo, which has to show up in the gallery.

The "post_type" of that kind of posts is "attachment", and "post_parent" is the "ID" field of the original post.

Thus it's possible to find the original post by 
```
SELECT ID FROM `wp_posts` where post_title='մարտի մեկ, հավաք' and post_status="publish";
```

Then get the links to the images by
```
SELECT guid FROM `wp_posts` WHERE post_parent="the_number_weve_got_from_previous_query" and post_type="attachment";
```

Well, I do not need exactly wp's gallery format. May be one day I'll leave wp, and what I need are those links to the images. I decided to generate simple html age that contains all those images. Wordpress already created smaller versions of my images, so, I'll take the smaller image to show, and use it as a link to the original image. This is basically what this script does.

That is why this [page](http://norayr.am/weblog/2009/03/01/274/) is accessible now.

P. S. 
Well, I actually switched from norayr.arnet.am to norayr.am, thus I needed to preserve old links that point to the old domain, also, old rss feeds.
This is solved by .htaccess
```
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteCond %{HTTP_HOST} ^norayr.arnet.am$ [NC]
RewriteRule ^(.*)$ http://norayr.am/$1 [R=301,L]
</IfModule>
```
apparently.
