import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/client.dart';

class ClientCubit extends Cubit<Client> {
  ClientCubit()
      : super(Client(
          id: "2dc6cf70-b5c9-11eb-91b2-d125bdc843eb",
          firstName: "Eleni",
          lastName: "Mpilisi",
        ));
}
