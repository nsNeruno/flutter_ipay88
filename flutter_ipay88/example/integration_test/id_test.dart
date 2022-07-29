import 'package:flutter_ipay88/flutter_ipay88.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const testItems = <ItemTransaction>[
    ItemTransaction(
      id: "ITEM-001",
      name: "First Fantasy",
      quantity: 123,
      amount: 7474,
      parentType: ItemTransactionParent.seller,
      parentId: "ADMIN",
    ),
    ItemTransaction(
      id: "ITEM-0MEGA",
      name: "End of The World",
      quantity: 666,
      amount: 666,
      parentType: ItemTransactionParent.seller,
      parentId: "ADMIN",
    ),
  ];

  const testAddress = IPayAddress(
    firstName: "Shadow",
    lastName: "Of The Realm",
    address: "Nowhere",
    city: "Darkness",
    state: "Void",
    postalCode: "666",
    phone: "911",
  );

  const testSellers = [
    IPaySeller(
      id: "ADMIN",
      name: "ADMIN_",
      sellerIdNumber: "147666",
      email: "admin@universe.com",
      address: IPayAddress(
        firstName: "Judge",
        lastName: "Cid",
        address: "Black Hole",
        city: "EM-666",
        state: "Unknown Galaxy",
        postalCode: "12345",
        phone: "911",
      ),
    ),
  ];

  var sdk = FlutterIPay88().sdkIDSandbox;
  var payment = IPayPayment();
  testWidgets(
    "IPay88 ID Test",
    (_) async {
      sdk.checkout(
        payment: payment,
        itemTransactions: testItems,
        shippingAddress: testAddress,
        sellers: testSellers,
        // method: null,
        // settingFields: null,
      );
    },
  );
}