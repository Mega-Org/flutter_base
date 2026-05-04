library app_pagination;

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/core.dart';
import 'package:flutter_base/core/utils/extensions/list_ext.dart';
import 'package:flutter_base/material/app_fail_widget.dart';
import 'package:flutter_base/material/loading/spin_kit_loading_widget.dart';

part 'src/controller/pagination_controller.dart';
part 'src/controller/pagination_controller_state.dart';
part 'src/controller/pagination_state.dart';
part 'src/models/paginated_status.dart';
part 'src/models/paginated_status_enum.dart';
part 'src/models/type_ahead.dart';
part 'src/views/paginated_grid_view.dart';
part 'src/views/paginated_list_view.dart';
part 'src/views/paginated_page_view.dart';
part 'src/widgets/builders.dart';
part 'src/widgets/failure_widgets.dart';
part 'src/widgets/loading_widgets.dart';
part 'src/widgets/pagination_listener.dart';
