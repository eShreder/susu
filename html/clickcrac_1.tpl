<div class="header">
	<h1>Click &#8211; <span>[кратия]</span></h1>
	<p>Власть в кликах</p>
</div>
<div><p>Теперь здесь можно голосовать за удобное время. Получится ли определить  и вообще работает голосовалка или нет - покажет <i>время</i></p></div>
<div id="boardDay" class="row">
{preload module=clickcracy data=recs result=recs}
{print_r($recs)}
{foreach from=$recs item=rec key=key}
	<div id="at-{$rec.day}-{$rec.actime}" href="{$rec.url_clear}" class="v-{$rec.count}">at-{$rec.day}-{$rec.actime}</div>
{/foreach}

</div>


{literal}
<script type="text/javascript">
$(function(){
	var //ac_times = $.parseJSON($('script[type="json/actime"]').html()),
		days = ['Пн.','Вт.','Ср.','Чт.','Пт.','Сб.','Вс.'],
		ctime = ['8:00-9:35','9:45-11:20','11:30-13:05','13:35-15:10','15:20-16:55','17:05-18:40','18:45-20:20','20:25-22:00'],
		boadr = $('#boardDay'),
		ac_times = boadr.children('div'),
		
		set_color = function(e){
			var v = parseInt($(e).attr('class').replace('v-',''),10)*10,
				color = '#'+((v<=0)?(128-v):128).toString(16)+((v>=0)?(128+v):128).toString(16)+'80'

			$(e).css('background',color)
			//console.log(color,v)
		},

		set_html = function(e){
			var a = $(e).attr('id').split('-')
			$(e).html('<span>'+days[eval(a[1])-1]+'</span>')
			$(e).append('<span>'+ctime[eval(a[2])-1]+'</span>')
			$(e).append('<div class="row"><a class="l">+</a><a class="dl">-</a></div>')
		},

		set_click_voting = function(){
			var e = $(this).parent().parent(),
				url = e.attr('href')
			$.ajax({
			  url: url+'.voting.json',
			  type: 'POST',
			  dataType: 'json',
			  data: {val: $(this).is('.dl')?'-1':'1'},
			  complete: function(xhr, textStatus) {
			    //called when complete
			  },
			  success: function(data, textStatus, xhr) {
			  	e.attr('class','v-'+data['now_count'])
			  	//console.log('v-'+data['now_count'])
			    set_color(e)
			  },
			  error: function(xhr, textStatus, errorThrown) {
			    //called when there is an error
			  }
			});
			return false;
		}
	ac_times.sort(function(a,b){
		//a = parseInt($(a).attr("timestamp"), 10);
    	//b = parseInt($(b).attr("timestamp"), 10);
    	a = $(a).attr('id').split('-')
    	b = $(b).attr('id').split('-')
    	if(eval(a[1]) > eval(b[1])) 
    	{
        	return 1;
	    } 
	    else if(eval(a[1]) < eval(b[1])) 
	    {
	        return -1;
	    } 
	    else 
	    {
	        if(eval(a[2]) > eval(b[2])) 
	        {
        		return 1;
	    	} 
	    	else if(eval(a[2]) < eval(b[2])) 
	    	{
	    		return -1;
	    	}

	    }
	})
	boadr.html(ac_times)
	ac_times = boadr.children('div')


	$.each(ac_times, function(index, val) {
		 set_color(val)
		 set_html(val)
		 $(val).find('a').click(set_click_voting)
	});



})</script>

{/literal}

