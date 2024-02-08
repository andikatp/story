import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/core/services/network_info.dart';
import 'package:story/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:story/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:story/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:story/features/auth/domain/repositories/auth_repository.dart';
import 'package:story/features/auth/domain/usecases/login.dart';
import 'package:story/features/auth/domain/usecases/register.dart';
import 'package:story/features/auth/domain/usecases/save_token.dart';
import 'package:story/features/auth/presentation/bloc/auth_bloc.dart';

part 'dependency_container.main.dart';
