function summernote_getFileInfo(fullName){
	
	var fileName,imgsrc,getLink;
	var fileLink;

	imgsrc="/displayFile?fileName="+fullName;
	fileLink = fullName.substr(14);
	var front = fullName.substr(0,12);
	var end=fullName.substr(14);
	
	getLink = "/displayFile?fileName="+front+end;
		

	
	fileName = fileLink.substr(fileLink.indexOf("_")+1);
	
	
	return getLink;
	

}