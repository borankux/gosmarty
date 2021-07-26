<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
{include file='admin/common/_it_head.tpl' mode=admin}
<body class="body_browse">
<div id="container" class="container_browse"> <a name="adm_top" id="adm_top"></a>
  {include file="admin/_admin_header.tpl" mode="log"}
  <div class="fsbar color_log_admin" id="v4-2">
    <form action="/admin/admin_log.php/" method="GET" name="_adm_search" id="_adm_log_search">
      <input id="operation_id" name="_opid" type="hidden" value="{$smarty.const.OP_INTERNAL_SEARCH}" />
      <table width="780px "border="0" cellspacing="3" cellpadding="0">
        <tr>
          <td width="78"><label for="{$smarty.const.ALOG_USER_ID}">Admin</label></td>
          <td width="209"><select name="{$smarty.const.ALOG_USER_ID}" id="{$smarty.const.ALOG_USER_ID}" class="_srch_field" onChange="if(this.value=={$smarty.const.ALOG_BOT_ID}) $('chk_walle').checked = 1;  " >
              <option value=""> All admins... </option>
              <option value="{$smarty.const.ALOG_BOT_ID}" {if !empty($smarty.get.user_id) &&  $smarty.get.user_id== $smarty.const.ALOG_BOT_ID } selected {/if} > {$smarty.const.ALOG_BOT_NAME}</option>
              {foreach from=$admins item=ad key=uid}
              {strip}
              <option value="{$ad.id}" {if $ad.id == $smarty.get.user_id} selected="true" {/if} >
				{if $ad.login != ''} {$ad.login} {else} {$ad.email} {/if}
              </option>
              {/strip}
              {/foreach}
            </select>
          <td width="76"><label for="{$smarty.const.ALOG_ACTION_DATE}">Action</label></td>
          <td width="372" colspan="2"><select name="{$smarty.const.ALOG_ACTION}" id="{$smarty.const.ALOG_ACTION}" class="_srch_field">
              <option value="" {if $smarty.get.$smarty.action == '' || $smarty.get.action== '0' } selected="selected" {/if} >Choose...</option>
              {section name=action start=1 step=1 loop=$smarty.const.ALOG_ACTION_MAX}
              <option value="{$smarty.section.action.index}" {if $smarty.get.action == $smarty.section.action.index} selected="selected" {/if}>
              {$i18n->getData('admin', "lbl_log_act_`$smarty.section.action.index`")|ucfirst}
              </option>
              {/section}
            </select></td>
        </tr>
        <tr>
          <td><label for="from">From</label></td>
          <td><input name="{$smarty.const.ALOG_ACTION_DATE}[]" id="from_date" type="text" class="_srch_field" value="{$smarty.get.action_date.0}" /></td>
          <td><label for="to">To</label></td>
          <td colspan="3"><input name="{$smarty.const.ALOG_ACTION_DATE}[]" id="to_date"  type="text" class="_srch_field" value="{$smarty.get.action_date.1}" /></td>
        </tr>
		{if !empty($smarty.get._id)}
        <tr>
          <td><label for="{$smarty.const.ALOG_TARGET}">Target</label></td>
          <td><input name="{$smarty.const.ALOG_TARGET}" type="text" class="_srch_field" value="{$smarty.get._id}" disabled /></td>
		</tr>
        {/if}
        <tr>
	        <td colspan="3" height="35"><input name="chk_walle" id="chk_walle" type="checkbox" value="{$smarty.const.ALOG_BOT_NAME}" {if isset($smarty.get.chk_walle) || $smarty.get._opid==1 } checked {/if} >Include {$smarty.const.ALOG_BOT_NAME} (System bot)</td>
        </tr>
        <tr>
          <td colspan="4" align="left"><input name="b_search" type="button" class="_srch_field" id="b_search" value="Submit" onClick="check_user_search('_adm_log_search'); return false;" />
            <input name="clear" type="button" value="Clear" onClick="clear_form('_adm_log_search');">
          </td>
        </tr>
      </table>
    </form>
  </div>
  {*if isset($smarty.get.user_id) && $smarty.get.user_id != '' }
  		<div class="log_stats">
    <table width="780px">
      <tr>
        <td colspan="3"><b>Stats for user: </b>
          {$smarty.get.user_id}</td>
      </tr>
      <tr>
      <td><b style="color:#990000">LAST DAY </b></td><td><b style="color:#990000">LAST WEEK </b></td><td><b style="color:#990000">LAST MONTH </b></td>
      </tr>
      <tr>
        <td valign="top">
          {foreach from=$d_stats item="act" key="kact"}
          <b>
          {$i18n->getData('admin', "lbl_log_act_`$kact`")|ucfirst}
          </b> =
          {$act}
          <br />
          {/foreach}
        </td>
        <td valign="top">
          {foreach from=$w_stats item="act" key="kact"}
          <b>
          {$i18n->getData('admin', "lbl_log_act_`$kact`")|ucfirst}
          </b> =
          {$act}
          <br />
          {/foreach}
        </td>
        <td valign="top">
          {foreach from=$m_stats item="act" key="kact"}
          <b>
          {$i18n->getData('admin', "lbl_log_act_`$kact`")|ucfirst}
          </b> =
          {$act}
          <br />
          {/foreach}
        </td>
      </tr>
    </table>
  </div>
  {/if*}
  <!-- RESULTS LAYER -->
  <div class="adm_error"></div>
  <div id="ff_cr_outer" class="ff-cr-outer">
    <div id="ff_center_outer" class="ff-cr-inner">
      <div id="CentralArea" class="centerAreaLeftNav">
        <div class="yukonggrcp-rcp" id="rsc">
          <div class="yukonggrcp-n">
            <div class="yukonggrcp-e">
              <div class="yukonggrcp-w"></div>
            </div>
          </div>
          <div id="rsc_mid" class="yukonggrcp-mid">
            <div id="rsc_mide">
              <div>
                <div id="v4-30" class="fpcc"> <span id="v4-31"> <span> <span class='countClass'>
                  {$total_count|number_format:0:".":","}
                  (showing
                  {$count}
                  ) </span> <span class='matchClass'>resultados encontrados</span> </span> </span> <span class="saveSearch"> </span> <span>[
                  {if isset($curr_search)}
                  {foreach from=$curr_search item="field" key="k"}
                  {$k}
                  {$field.op}
                  {$field.val}
                  {/foreach}
                  {/if}
                  ] </span> <span class="fpcshowall"></span>
                  <div class="basOlp-olp">
                    <div style="width:300px" class="basOlp-oly">
                      <div class="basOlp-sdowbox" style="filter:alpha(opacity=15);-moz-opacity:0.15;opacity: 0.15;">
                        <div class="basOlp-n">
                          <div class="basOlp-scn">
                            <div class="basOlp-scn"></div>
                          </div>
                        </div>
                        <div class="basOlp-ctent" id="v4-34olpshadow"></div>
                        <div class="basOlp-s">
                          <div class="basOlp-scn">
                            <div class="basOlp-scn"></div>
                          </div>
                        </div>
                      </div>
                      <div id="v4-34olpctnbox" class="basOlp-ctentbox">
                        <div id="v4-34_cnt_n" class="basOlp-n">
                          <div class="basOlp-cn">
                            <div class="basOlp-cn"></div>
                          </div>
                        </div>
                        <div class="basOlp-ctent" id="v4-34olpcontent">
                          <div class="basOlp-ctentholder">
                            <div id="v4-34olppanel"> <span id="v4-35"> </span> </div>
                          </div>
                        </div>
                        <div class="basOlp-s">
                          <div class="basOlp-cn">
                            <div class="basOlp-cn"></div>
                          </div>
                        </div>
                        <div id="v4-34olparrow" class="basOlp-aTL"></div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div id="v4-36" style="display:none"></div>
              <div class="sidePadding constrainttop"></div>
              <div id="v4-37" style="display:none" class="bpMsg"></div>
              <div id="rtm_html_271" class="rtmHide"></div>
              <div id="v4-47" class="rs_box">
                <div class="cmpb" id="v4-68" style="width:100%;padding-left:0px;">
                  <!--<a href="#" onClick="admin_check_all(1);">Check All</a> | <a href="#" onClick="admin_check_all(0);">Uncheck All</a> | -->
                </div>
                <form id="adm_browse_check" name="adm_browse_check" action="/admin/admin_log_actions.php" method="POST" onSubmit="return adm_validate(this);">
                  <input id="operation_id" name="operation_id" type="hidden" value="" />
                  <input name="_user_id" id="_user_id" type="hidden" value="" />
                  <input name="_user_email" id="_user_email" type="hidden" value="" />
                  <input name="_user_comment" id="_user_comment" type="hidden" value="" />
                  <div id="v4-69" style="width:100%">
                    <div id="v4-70">
                      <div id="adm_results" class="">
                        {if $count > "0" }
                        {assign var="first_row" value=true}
                        {foreach item="log" from=$browse}
                        {if !$first_row }
                        <div class="hr2"></div>
                        {else}
                        {assign var="first_row" value=false}
                        {/if}
                        <div class="_adm_post">
                          <table width="100%" class="nol" cellspacing="0" cellpadding="3">
                            <tr>
                              <td width="*" class="details ttl"><div class="adm_log">
                                  <!--                                <input id="log_{$log[$smarty.const.ALOG_ID]}" name="chk_logs[]" type="checkbox" value="{$log[$smarty.const.ALOG_ID]}" class="chk_post" onClick="admin_check(this)"/>
                                <span>Log Id#:{$log[$smarty.const.ALOG_ID]}</span> |-->
                                  <span><b>
                                  {if empty($log.ulogin)}
	                                  	{if ($log.user_id == $smarty.const.ALOG_BOT_ID)}
		                                  	{$smarty.const.ALOG_BOT_NAME}
                                        {else}
                                        	No alias (uid=<a href="/admin/admin_users.php?_opid=1&id={$log.user_id}">{$log.user_id}</a>)                                       {/if}
                                  {else}
	                                  	{$log.ulogin}
                                  {/if}
                                  </b></span> | <span class="st">
                                  {$i18n->getData('admin',"lbl_log_act_`$log[$smarty.const.ALOG_ACTION]`")|ucfirst}
                                  </span>
                                  {if $log[$smarty.const.ALOG_TARGET_TYPE] == ALOG_TARGET_USER && $log[$smarty.const.ALOG_TARGET] > 0}
                                      (<a href="/admin/admin_users.php?_opid=1&id={$log[$smarty.const.ALOG_TARGET]}">User Id:
                                      {$log[$smarty.const.ALOG_TARGET]}
                                      </a>)
                                  {elseif $log[$smarty.const.ALOG_TARGET_TYPE] == ALOG_TARGET_POST && $log[$smarty.const.ALOG_TARGET] > 0}
                                      (<a href="/admin/?_opid=2&post_id={$log[$smarty.const.ALOG_TARGET]}">Post Id:
                                      {$log[$smarty.const.ALOG_TARGET]}
                                      </a>)
                                  {elseif $log[$smarty.const.ALOG_TARGET_TYPE] == ALOG_TARGET_REPLY && $log[$smarty.const.ALOG_TARGET] > 0}
                                      (<a href="/admin/admin_replies.php?_opid=1&reply_id={$log[$smarty.const.ALOG_TARGET]}">Reply Id:
                                      {$log[$smarty.const.ALOG_TARGET]}
	                                  </a>)
                                  {/if}
                                  | <span>
                                  {$log[$smarty.const.ALOG_ACTION_DATE]}
                                  </span> | <span class="grey2" style="overflow:hidden"><i>
                                  {$log[$smarty.const.ALOG_PARAMS]}
                                  </i></span> </div></td>
                            </tr>
                          </table>
                        </div>
                        {/foreach}
                        {/if}
                        <br>
                      </div>
                    </div>
                  </div>
                </form>
                  {literal}
                  <script type="text/javascript">
                    Control.DatePicker.Locale['ebay'] = { dateTimeFormat: 'yyyy-MM-dd HH:mm:ss', dateFormat: 'yyyy-MM-dd', firstWeekDay: 1, weekend: [0,6], language: 'es'};
                    var param = {icon: '/images/calendar.png', use24hrs: true, locale:'ebay'};
                    var picker1 = new Control.DatePicker('from_date', param );
                    var picker2 = new Control.DatePicker('to_date', param );
                  </script>
                  {/literal}
                <div id="rtm_html_275"></div>
                <div class="compare" style="text-align:center;" id="v4-71">
	                <div class="page"><b>P�gina
                    {$current_page}
                    </b> de <span>
                    {$total_pages|number_format:0:".":","}
                    </span></div>
                </div>
                <div id="v4-74" class="dynpg dynpg_admin">
                  <table class="pager" align="center" cellpadding="0" cellspacing="0">
                    <tbody>
                      <tr>
                        <td class="prev">{if $current_page!=1}
                          	<span class="link_js" onclick="adm_Paginate({$current_page-1})"> Anterior</span>
                          {else }
                          	<span class="disabled">Anterior</span>
                          {/if}
                        </td>
                        <td class="next">
                          | {if $current_page<$total_pages}
                          	<span class="link_js" onclick="adm_Paginate({$current_page+1})"> Siguiente</span>
                          {else}
                          	<span class="disabled">Siguiente</span>
                          {/if}
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
          <!-- esto da problemas en explorer -->
          <div class="yukonggrcp-s">
            <div class="yukonggrcp-e">
              <div class="yukonggrcp-w"></div>
            </div>
          </div>
        </div>
        <div id="v4-86" style="display:none"></div>
        <div class="whiter-rcp promoContainer" id="PROMO74541NSRP">
          <div class="whiter-n">
            <div class="whiter-e">
              <div class="whiter-w"></div>
            </div>
          </div>
          <div id="PROMO74541NSRP_head" class="whiter-head">
            <div id="PROMO74541NSRP_heade">
              <div id="ME74541NSRP_head"></div>
            </div>
          </div>
          <div id="PROMO74541NSRP_mid" class="whiter-mid">
            <div id="PROMO74541NSRP_mide" class="whiter-mide2">
              <div id="ME74541NSRP_body"></div>
            </div>
          </div>
          <div class="whiter-s_nf">
            <div class="whiter-e">
              <div class="whiter-w"></div>
            </div>
          </div>
        </div>
        <div id="rtm_html_393" class="footerTextAd rtmHide"></div>
        <div class="panelSpacing"></div>
        <div id="v4-89"></div>
        <div id="pageId"></div>
        <span class="ebay"> </span> </div>
    </div>
  </div>
</div>
</body>
</html>

