class Loading {
  static Future response(Function result) async{
    bool responseGotten = true;
    while(responseGotten){
       final response = await result();
       if (response != null)
         return response;
    }
  }
}