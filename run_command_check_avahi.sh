`echo $@  | 
awk '{ 
	numArgs = NF;
	finalCommand = "";
	split($0,inputArray," ");
	regex = "\.local";  
	for(i = 1; i <= numArgs; i++) { 
		where = match(tolower(inputArray[i]), regex);
         	if (where != 0) {
			domainName = substr(inputArray[i],1,where+5);
			sub(/^.*@/,"",domainName);
			avahiCommand = "avahi-resolve-host-name -4 " domainName;
  			if (avahiCommand | getline) {
				sub(domainName,$2,inputArray[i]);
  			}
  			close(avahiCommand);
			
		} 
		finalCommand = finalCommand " " inputArray[i];
	} 
	print finalCommand;
}'`
