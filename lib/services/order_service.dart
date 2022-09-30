import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecoshops/models/detailOrder.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'package:flutter_ecoshops/models/order.dart';
import 'package:flutter_ecoshops/models/user.dart';

class OrderService extends ChangeNotifier {
  final List<DetailOrder> orders = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late DocumentReference _order;

  OrderService();

  void addDetail(String productID, int amount, Product product) {
    var newDetail = new DetailOrder(
        amount: amount,
        finalPrice: amount * product.price,
        idProduct: productID,
        product: product);

    orders.add(newDetail);
  }

  int getTotal() {
    var total = 0;
    orders.forEach((ord) {
      total = total + ord.finalPrice;
    });
    return total;
  }

  Future sendOrder(Account user) async {
    // Creando nueva orden
    var newOrder = new Order(
        address: user.address,
        idUser: user.id!,
        mail: user.mail,
        orderDate: DateTime.now(),
        status: "Confirmación pendiente.",
        tax: 19,
        totalPrice: this.getTotal());

    // Insertando la orden en la colección order
    _order = _firestore.collection('order').doc();
    await _order.set(newOrder.toMap());

    // Insertando detalles de orden
    await Future.forEach(orders, (DetailOrder ord) async {
      // Insertando el detalle de la orden
      var _detail = _order.collection('detail_order').doc();
      await _detail.set(ord.toMap());

      // Actualizando el stock del producto
      var _prod = _firestore.collection('product').doc(ord.idProduct);
      await _prod.update({'stock': ord.product!.stock - ord.amount});
    });
  }

  Future<List> getOrders(String userID) async {
    List ordersList = [];
    var order = _firestore.collection("order");
    var userOrders = await order.where("id_user", isEqualTo: userID).get();
    await Future.forEach(userOrders.docs,
        (QueryDocumentSnapshot element) async {
      Map dato = element.data() as dynamic;
      dato["products"] = [];
      var detalles = await FirebaseFirestore.instance
          .collection("order")
          .doc(element.id)
          .collection("detail_order")
          .get();
      await Future.forEach(detalles.docs,
          (QueryDocumentSnapshot element2) async {
        Map elementData = element2.data() as dynamic;
        var producto = await FirebaseFirestore.instance
            .collection("product")
            .doc(elementData["id_product"])
            .get();
        var dataProducto = producto.data();
        dato["products"].add(dataProducto!["name_prod"]);
      });
      ordersList.add(dato);
    });
    return ordersList;
  }

  Future<List> getOrdersByEnt(String entID) async {
    List ordersList = [];
    var order = _firestore.collection("order");
    var userOrders = await order.get();
    await Future.forEach(userOrders.docs,
        (QueryDocumentSnapshot element) async {
      Map dato = element.data() as dynamic;
      dato["products"] = [];
      bool flag = false;
      var detalles = await FirebaseFirestore.instance
          .collection("order")
          .doc(element.id)
          .collection("detail_order")
          .get();
      await Future.forEach(detalles.docs,
          (QueryDocumentSnapshot element2) async {
        Map elementData = element2.data() as dynamic;
        var producto = await FirebaseFirestore.instance
            .collection("product")
            .doc(elementData["id_product"])
            .get();
        var dataProducto = producto.data() as dynamic;
        if (dataProducto["id_entrepreneurship"] == entID) {
          flag = true;
          dato["products"].add(dataProducto!["name_prod"]);
        }
      });
      if (flag) {
        ordersList.add(dato);
      }
    });
    return ordersList;
  }
}
