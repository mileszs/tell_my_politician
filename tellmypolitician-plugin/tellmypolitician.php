<?php
/*
Plugin Name: TellMyPolitician
Version: 1.0
Plugin URI: http://tellmypolitician.com/tools/wp
Description: Adds a footer link to a current post or page that lets users share articles with their politician. This plugin code was originally created by <a href="http://nothing.golddave.com/">David Goldstein</a> for his <a href="http://nothing.golddave.com/?page_id=108">Add To Facebook</a> plugin.
Author: Tim Flint
Author URI: http://tellmypolitician.com/
*/
/*
Copyright (c) 2009, TellMyPolitician
All rights reserved.
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
	¥	Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
	¥	Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
	¥	Neither the name of the TellMyPolitician nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
function tell_my_politician($data){
	global $post;
	$current_options = get_option('tell_my_politician_options');
	$linktype = $current_options['link_type'];
	switch ($linktype) {
		case "text":
			$data=$data."<p class=\"tellmypolitician\"><a href=\"http://tellmypolitician.com/search?u=".urlencode(get_permalink($post->ID))."&title=".urlencode($post->post_title)."&client=2"."\" target=\"_blank\" title=\"Contact Your Representatives\">TellMyPolitician</a></p>";
			break;
		case "image":
			$data=$data."<p class=\"tellmypolitician\"><a href=\"http://tellmypolitician.com/search?u=".urlencode(get_permalink($post->ID))."&title=".urlencode($post->post_title)."&client=2"."\" target=\"_blank\"><img src=\"".get_bloginfo(wpurl)."/wp-content/plugins/tellmypolitician-plugin/tmp_icon.jpg\" alt=\"TellMyPolitician\" title=\"Contact Your Representatives\" /></a></p>";
			break;
		case "both":
			$data=$data."<p class=\"tellmypolitician\"><a href=\"http://tellmypolitician.com/search?u=".urlencode(get_permalink($post->ID))."&title=".urlencode($post->post_title)."&client=2"."\" target=\"_blank\"><img src=\"".get_bloginfo(wpurl)."/wp-content/plugins/tellmypolitician-plugin/tmp_icon.jpg\" alt=\"TellMyPolitician\" title=\"Contact Your Representatives\" /></a><a href=\"http://tellmypolitician.com/search?u=".urlencode(get_permalink($post->ID))."&title=".urlencode($post->post_title)."&client=2"."\" target=\"_blank\" title=\"Contact Your Representatives\">TellMyPolitician</a></p>";
			break;
		}
		return $data;
}

function activate_tell_my_politician(){
	global $post;
	$current_options = get_option('tell_my_politician_options');
	$insertiontype = $current_options['insertion_type'];
	if ($insertiontype != 'template'){
		add_filter('the_content', 'tell_my_politician', 10);
		add_filter('the_excerpt', 'tell_my_politician', 10);
	}
}

activate_tell_my_politician();

function tellmypolitician(){
	global $post;
	$current_options = get_option('tell_my_politician_options');
	$insertiontype = $current_options['insertion_type'];
	if ($insertiontype != 'auto'){
		$linktype = $current_options['link_type'];
		switch ($linktype) {
			case "text":
				echo "<p class=\"tellmypolitician\"><a href=\"http://tellmypolitician.com/search?u=".urlencode(get_permalink($post->ID))."&title=".urlencode($post->post_title)."&client=2"."\" target=\"_blank\" title=\"Contact Your Representatives\">TellMyPolitician</a></p>";
				break;
			case "image":
				echo "<p class=\"tellmypolitician\"><a href=\"http://tellmypolitician.com/search?u=".urlencode(get_permalink($post->ID))."&title=".urlencode($post->post_title)."&client=2"."\" target=\"_blank\"><img src=\"".get_bloginfo(wpurl)."/wp-content/plugins/tellmypolitician-plugin/tmp_icon.jpg\" alt=\"TellMyPolitician\" title=\"Contact Your Representatives\" /></a></p>";
				break;
			case "both":
				echo "<p class=\"tellmypolitician\"><a href=\"http://tellmypolitician.com/search?u=".urlencode(get_permalink($post->ID))."&title=".urlencode($post->post_title)."&client=2"."\" target=\"_blank\"><img src=\"".get_bloginfo(wpurl)."/wp-content/plugins/tellmypolitician-plugin/tmp_icon.jpg\" alt=\"TellMyPolitician\" title=\"Contact Your Representatives\" /></a><a href=\"http://tellmypolitician.com/search?u=".urlencode(get_permalink($post->ID))."&title=".urlencode($post->post_title)."&client=2"."\" target=\"_blank\" title=\"Contact Your Representatives\">TellMyPolitician</a></p>";
				break;
			}
		}
}

// Create the options page
function tell_my_politician_options_page() { 
	$current_options = get_option('tell_my_politician_options');
	$link = $current_options["link_type"];
	$insert = $current_options["insertion_type"];
	if ($_POST['action']){ ?>
		<div id="message" class="updated fade"><p><strong>Options saved.</strong></p></div>
	<?php } ?>
	<div class="wrap" id="tell-my-politician-options">
		<h2>TellMyPoliticians Options</h2>
		
		<form method="post" action="<?php echo $_SERVER['PHP_SELF']."?".$_SERVER['QUERY_STRING']; ?>">
			<fieldset>
				<legend>Options:</legend>
				<input type="hidden" name="action" value="save_tell_my_politician_options" />
				<table width="100%" cellspacing="2" cellpadding="5" class="editform">
					<tr>
						<th valign="top" scope="row"><label for="link_type">Link Type:</label></th>
						<td><select name="link_type">
						<option value ="text"<?php if ($link == "text") { print " selected"; } ?>>Text Only</option>
						<option value ="image"<?php if ($link == "image") { print " selected"; } ?>>Image Only</option>
						<option value ="both"<?php if ($link == "both") { print " selected"; } ?>>Image and Text</option>
						</select></td>
					</tr>
					<tr>
						<th valign="top" scope="row"><label for="insertion_type">Insertion Type:</label></th>
						<td><select name="insertion_type">
						<option value ="auto"<?php if ($insert == "auto") { print " selected"; } ?>>Auto</option>
						<option value ="template"<?php if ($insert == "template") { print " selected"; } ?>>Template</option>
						</select></td>
					</tr>
				</table>
			</fieldset>
			<p class="submit">
				<input type="submit" name="Submit" value="Update Options &raquo;" />
			</p>
		</form>
	</div>
<?php 
}

function tell_my_politician_add_options_page() {
	// Add a new menu under Options:
	add_options_page('TellMyPolitician', 'TellMyPolitician', 10, __FILE__, 'tell_my_politician_options_page');
}

function tell_my_politician_save_options() {
	// create array
	$tell_my_politician_options["link_type"] = $_POST["link_type"];
	$tell_my_politician_options["insertion_type"] = $_POST["insertion_type"];
	
	update_option('tell_my_politician_options', $tell_my_politician_options);
	$options_saved = true;
}

add_action('admin_menu', 'tell_my_politician_add_options_page');

if (!get_option('tell_my_politician_options')){
	// create default options
	$tell_my_politician_options["link_type"] = 'text';
	$tell_my_politician_options["insertion_type"] = 'auto';
	
	update_option('tell_my_politician_options', $tell_my_politician_options);
}

if ($_POST['action'] == 'save_tell_my_politician_options'){
	tell_my_politician_save_options();
}

function tellmypoliticiancss() {
	?>
	<link rel="stylesheet" href="<?php bloginfo('wpurl'); ?>/wp-content/plugins/tellmypolitician-plugin/tellmypolitician.css" type="text/css" media="screen" />
	<?php
}

add_action('wp_head', 'tellmypoliticiancss');
?>
