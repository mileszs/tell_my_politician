=== Plugin Name ===
Contributors: David Goldstein - Tim Flint
Tags: Tell My Politician
Requires at least: 2.0
Tested up to: 2.7
Stable tag: trunk

This plugin adds a footer link to share the current post or page with your politician using TellMyPolitician.com.

== Description ==
This plugin adds a footer link to share the current post or page with your politician using TellMyPolitician.com.  While the plugin is activated a link will appear after the content of the post with the text "TellMyPolitician" or the TellMyPolitician icon or both. Clicking this link will bring the user to the TellMyPolitician site.  Once on TellMyPolitician the user will be directed to input their address, to find their politician. Then when they click to email a politician they will have the ability to copy and past your site link into the email field, to tell the politican about the article on your site. 

== Installation ==
1. Add the folder called tellmypolitician-plugin (without the quotes) to your '/wp-content/plugins/' directory.
2. Activate the plugin through the 'Plugins' menu in WordPress.
1. Go to 'Settings-> TellMyPolitician' in your admin interface to select you options.

== CSS ==
The CSS for this plugin is found in the included tellmypolitician.css file.  This file may be edited to change the style of the link.

== Options ==
There are two options on the options page: Link Type and Insertion Type.

Link Type - This option sets if you want your TellMyPolitican link to be text, image or both.

Insertion Type - This option sets how you want to insert the link into your posts/pages.  There are two choices: auto or template.

* Auto - When insertion type is set to auto the TellMyPolitician link will automatically be inserted right after the post.
* Template - When insertion type is set to template the TellMyPolitician link will appear wherever the template tag for the plugin is added to your theme. This option requires a template tag to be added to your theme.

== Template Tag ==
The following template tag must be added to your theme in the location you want the link to appear when insertion type is set to template:

`<?php if(function_exists(tellmypolitician)) : tellmypolitician(); endif; ?>`