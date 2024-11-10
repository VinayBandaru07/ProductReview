import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login', style: TextStyle(fontSize: 24)),
              TextField(decoration: InputDecoration(labelText: 'Email')),
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()));
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Register', style: TextStyle(fontSize: 24)),
              TextField(decoration: InputDecoration(labelText: 'Email')),
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> products = ['Product 1', 'Product 2', 'Product 3'];
  final Set<String> cart = {};
  final Set<String> disliked = {};

  void _updateCart(String item, bool isAdding) {
    setState(() {
      if (isAdding) {
        cart.add(item);
      } else {
        cart.remove(item);
      }
    });
  }

  void _updateDisliked(String item, bool isAdding) {
    setState(() {
      if (isAdding) {
        disliked.add(item);
      } else {
        disliked.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          // Row for Cart and Disliked buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(
                          cart: cart,
                          updateCart: _updateCart,
                        ),
                      ),
                    );
                  },
                  child: Text('Cart (${cart.length})'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DislikedPage(
                          disliked: disliked,
                          updateDisliked: _updateDisliked,
                        ),
                      ),
                    );
                  },
                  child: Text('Disliked (${disliked.length})'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network('https://picsum.photos/200/300'),
                    title: Text(products[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            _updateCart(products[index], true);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.thumb_down),
                          onPressed: () {
                            _updateDisliked(products[index], true);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final Set<String> cart;
  final Function(String, bool) updateCart;

  CartPage({required this.cart, required this.updateCart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: ListView.builder(
        itemCount: widget.cart.length,
        itemBuilder: (context, index) {
          String item = widget.cart.elementAt(index);
          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () {
                setState(() {
                  widget.updateCart(item, false);
                });
              },
            ),
          );
        },
      ),
    );
  }
}

class DislikedPage extends StatefulWidget {
  final Set<String> disliked;
  final Function(String, bool) updateDisliked;

  DislikedPage({required this.disliked, required this.updateDisliked});

  @override
  _DislikedPageState createState() => _DislikedPageState();
}

class _DislikedPageState extends State<DislikedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disliked Items'),
      ),
      body: ListView.builder(
        itemCount: widget.disliked.length,
        itemBuilder: (context, index) {
          String item = widget.disliked.elementAt(index);
          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () {
                setState(() {
                  widget.updateDisliked(item, false);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
