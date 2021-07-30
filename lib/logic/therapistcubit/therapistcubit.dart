import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/therapist.dart';

class TherapistCubit extends Cubit<Therapist> {
  TherapistCubit()
      : super(Therapist(
            id: "pSn6YIRx3yOWKqnvJpgv",
            firstName: "Maria",
            lastName: "Andersen",
            email: "maria@andersen.com",
            address: "Gyngemose Parkvej, 2C, 6tv, 2860",
            phone: "+45 98 76 45 63"));
}
