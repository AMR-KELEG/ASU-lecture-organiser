/*
	jQuery document ready.
*/
$(document).ready(function()
{
	/*
		assigning keyup event to password field
		so everytime user type code will execute
	*/

	$('#user_password').keyup(function()
	{
		$('#result').html(checkStrength($('#user_password').val()))
	})	
	
	/*
		checkStrength is function which will do the 
		main password strength checking for us
	*/
	
	function checkStrength(password)
	{
		//initial strength
		var strength = 0
		
		//if the password length is less than 8, return message.
		if (password.length < 8) { 
			$('#result').removeClass()
			$('#result').addClass('short')
			return 'Too short' 
		}
		
		//length is ok, lets continue.
		
		//if length is 9 characters or more, increase strength value
		if (password.length > 8) strength += 1
		
		//if password contains both lower and uppercase characters, increase strength value
		if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  strength += 1
		
		//if it has numbers and characters, increase strength value
		if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/))  strength += 1 
		
		//if it has one special character, increase strength value
		if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/))  strength += 1
		
		//if it has two special characters, increase strength value
		if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1
		
		//now we have calculated strength value, we can return messages
		
		//if value is less than 2
		if (strength < 2 )
		{
			$('#result').removeClass()
			$('#result').addClass('weak')
			return 'Weak'			
		}
		else if (strength == 2 )
		{
			$('#result').removeClass()
			$('#result').addClass('good')
			return 'Good'		
		}
		else
		{
			$('#result').removeClass()
			$('#result').addClass('strong')
			return 'Strong'
		}
	}
});