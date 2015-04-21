<div class="product-filter clearfix">
    <div class="display pull-left">
		<span><?php echo $text_display; ?></span>
		<span><?php echo $text_list; ?></span>
		<a onclick="display('grid');"><span class="glyphicon glyphicon-align-justify"></span><?php echo $text_grid; ?></a>
	</div>
	<div class="pull-right">
		<div class="sort">
			<span class="pull-left"><?php echo $text_sort; ?></span>
	    	<div class="select-style pull-left">
	    		<select onchange="location = this.value;" class="form-filter">
			        <?php foreach ($sorts as $sorts) { ?>
			        <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
			        <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
			        <?php } else { ?>
			        <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
			        <?php } ?>
			        <?php } ?>
		     	</select>
	    	</div>
    	</div>


		<div class="limit">
			<span class="pull-left"><?php echo $text_limit; ?></span>
			<div class="select-style pull-left">
				<select onchange="location = this.value;" class="form-filter">
			        <?php foreach ($limits as $limits) { ?>
			        <?php if ($limits['value'] == $limit) { ?>
			        <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
			        <?php } else { ?>
			        <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
			        <?php } ?>
			        <?php } ?>
			    </select>
			</div>
	    </div>
	    
	</div>
</div>