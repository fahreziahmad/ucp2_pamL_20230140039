import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/catalog/catalog_bloc.dart';
import '../../blocs/catalog/catalog_event.dart';
import '../../blocs/catalog/catalog_state.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import 'login_screen.dart';
import 'add_car_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CatalogBloc>().add(FetchCatalog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DriveEase Fleet'),
        backgroundColor: const Color(0xFF1e3c72),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          if (state is CatalogLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CatalogLoaded) {
            if (state.cars.isEmpty) {
              return const Center(child: Text('No cars available'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.cars.length,
              itemBuilder: (context, index) {
                final car = state.cars[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.car_rental, color: Color(0xFF1e3c72)),
                    ),
                    title: Text(
                      '${car.name} ${car.model}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Year: ${car.year} | ${car.categoryName ?? "No Category"}'),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${car.pricePerDay.toStringAsFixed(0)} / day',
                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => AddCarScreen(car: car)),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _showDeleteDialog(context, car.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is CatalogFailure) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Initialize catalog...'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1e3c72),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCarScreen()),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Car'),
        content: const Text('Are you sure you want to remove this car?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              context.read<CatalogBloc>().add(DeleteCar(id));
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
