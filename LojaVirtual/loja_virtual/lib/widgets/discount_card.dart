import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/widgets/cart_price.dart';
class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
          title: Text("Cupom de Desconto",
          textAlign: TextAlign.start ,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
            ),
          ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom"
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text){
                Firestore.instance.collection("coupons").document(text).get().then((docSnap){
                  if(docSnap.data != null){
                    CartModel.of(context).setCoupon(text, docSnap.data["percent"]);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Desconto de ${docSnap.data["percent"]}% aplicado"),
                      backgroundColor: Theme.of(context).primaryColor,)
                    );
                  }else{
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Cupom Inválido!"),
                          backgroundColor: Colors.redAccent,)
                    );
                  }
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: CartModel.of(context).getDiscount()!=0.0 ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                  child: Text("Remover Cupom"),
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  onPressed: (){
                    if(CartModel.of(context).getDiscount() != 0.00){
                      CartModel.of(context).setCoupon(null, 0);
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Cupom Removido!"),
                            backgroundColor: Colors.redAccent,)
                      );
                    }
                  },
                ),
              ],
            ): null,
          ),
        ],
      ),
    );
  }
}
