<?php
/* Smarty version 3.1.36, created on 2022-02-26 21:56:00
  from '/home/littlecloud/public_html/portal/templates/emyui/password-reset-email-prompt.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.36',
  'unifunc' => 'content_621aa1f02ad718_68363416',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'ed3219b4327db4eb6e51e7327649306831836883' => 
    array (
      0 => '/home/littlecloud/public_html/portal/templates/emyui/password-reset-email-prompt.tpl',
      1 => 1625815722,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_621aa1f02ad718_68363416 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="mb-4">
    <h6 class="h3"><?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['lang'][0], array( array('key'=>'pwreset'),$_smarty_tpl ) );?>
</h6>
    <p class="text-muted mb-0"><?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['lang'][0], array( array('key'=>'pwresetemailneeded'),$_smarty_tpl ) );?>
</p>
</div>

<?php if ($_smarty_tpl->tpl_vars['errorMessage']->value) {?>
    <?php $_smarty_tpl->_subTemplateRender(((string)$_smarty_tpl->tpl_vars['template']->value)."/includes/alert.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('type'=>"error",'msg'=>$_smarty_tpl->tpl_vars['errorMessage']->value,'textcenter'=>true), 0, true);
}?>

<form method="post" action="<?php echo routePath('password-reset-validate-email');?>
" role="form">
    <input type="hidden" name="action" value="reset" />

    <div class="form-group">
        <label for="inputEmail"><?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['lang'][0], array( array('key'=>'loginemail'),$_smarty_tpl ) );?>
</label>
        <div class="input-group input-group-merge">
            <div class="input-group-prepend">
              <span class="input-group-text"><i class="fas fa-user"></i></span>
            </div>
            <input type="email" class="form-control" name="email" id="inputEmail" placeholder="name@example.com" autofocus>
          </div>
    </div>

    <?php if ($_smarty_tpl->tpl_vars['captcha']->value->isEnabled()) {?>
        <div class="text-center margin-bottom">
            <?php $_smarty_tpl->_subTemplateRender(((string)$_smarty_tpl->tpl_vars['template']->value)."/includes/captcha.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, true);
?>
        </div>
    <?php }?>

    <div class="form-group text-center">
        <button type="submit" class="btn btn-primary<?php echo $_smarty_tpl->tpl_vars['captcha']->value->getButtonClass($_smarty_tpl->tpl_vars['captchaForm']->value);?>
">
            <?php echo call_user_func_array( $_smarty_tpl->smarty->registered_plugins[Smarty::PLUGIN_FUNCTION]['lang'][0], array( array('key'=>'pwresetsubmit'),$_smarty_tpl ) );?>

        </button>
    </div>

</form>
<?php }
}
