<div class="row">
	<div class="col-lg-6 col-sm-6 col-xs-12">
	  <h2><?php echo $text_new_customer; ?></h2>
	  <p><?php /*echo $text_checkout;*/ ?></p>

	  <p><?php echo $text_register_account; ?></p>
        <label for="register">
	  	<?php if ($account == 'register') { ?>
		    <input type="radio" name="account" value="register" id="register" checked="checked" />
        <?php } else { ?>
		<input type="radio" name="account" value="register" id="register" />
		<?php } ?>
		<b><?php /*echo $text_register;*/ ?></b></label>
	  <br />
	  <input type="button" value="<?php echo $button_continue; ?>" id="button-account" class="button" name="register"/>
	  <br />
	  <br />
	</div>
	<div id="login" class="col-lg-6 col-sm-6 col-xs-12">
	  <h2><?php echo $text_returning_customer; ?></h2>
	  <p><?php echo $text_i_am_returning_customer; ?></p>
	  <b><?php echo $entry_email; ?></b><br />
	  <input type="text" name="email" value="" />
	  <br />
	  <br />
	  <b><?php echo $entry_password; ?></b><br />
	  <input type="password" name="password" value="" />
	  <br />
	  <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
	  <br />
	  <input type="button" value="<?php echo $button_login; ?>" id="button-login" class="button" /><br />
	  <br />
	</div>
</div>