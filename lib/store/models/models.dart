// ignore_for_file: non_constant_identifier_names

class Account {
  late String username;
  String? token;
  late String? first_name;
  late String? last_name;
  late Profile profile;
  bool is_superuser = false;

  Account();

  Account.fromJson(Map<String, dynamic> json) {
    token = json['token'] ?? json['key'];
    username = json['username'] ?? json['user']['username'];
    first_name = json['first_name'] ?? json['user']['first_name'];
    last_name = json['last_name'] ?? json['user']['last_name'];
    is_superuser = json['is_superuser'] ?? json['user']['is_superuser'];
    profile = Profile.fromJson(json['profile'] ?? json['user']['profile']);
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'token': token,
        'first_name': first_name,
        'last_name': last_name,
        'is_superuser': is_superuser,
        'profile': profile.toJson(),
      };
}

class Profile {
  late int id;
  late String? main_back_username;
  late String? third_name;
  late String? phone_number;
  late String? telegram_user_id;
  late String? code;
  late String? job_title;

  bool can_make_work = true;
  bool deletion_mark = false;

  bool it_is_brigadir = false;
  bool it_is_zav = false;

  Profile();

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main_back_username = json['main_back_username'];
    third_name = json['third_name'];
    phone_number = json['phone_number'];
    telegram_user_id = json['telegram_user_id'];
    code = json['code'];
    job_title = json['job_title'];
    can_make_work = json['can_make_work'];
    deletion_mark = json['deletion_mark'];
    it_is_brigadir = json['it_is_brigadir'];
    it_is_zav = json['it_is_zav'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'main_back_username': main_back_username,
        'third_name': third_name,
        'phone_number': phone_number,
        'telegram_user_id': telegram_user_id,
        'code': code,
        'job_title': job_title,
        'can_make_work': can_make_work,
        'deletion_mark': deletion_mark,
        'it_is_brigadir': it_is_brigadir,
        'it_is_zav': it_is_zav,
      };
}

class User {
  late String username;
  late String profile;

  User();

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() => {'username': username, 'profile': profile};
}

class GroupTask {
  late int id;
  late DateTime date_time_create;
  late String author_name;
  late String operation_name;
  late String? description;
  late String row_text;
  late String rows;
  late String greenhouse_name;
  late DateTime date;
  List<User> executors = [];
  late int all_task_count;
  late int completed_tasks_count;
  late int pause_tasks_count;
  late int in_work_tasks_count;

  GroupTask();

  GroupTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date_time_create = DateTime.parse(json['date_time_create']);
    author_name = json['author_name'];
    operation_name = json['operation_name'];
    description = json['description'];
    row_text = json['row_text'] ?? '';
    rows = json['rows'] ?? '';
    greenhouse_name = json['greenhouse_name'];
    date = DateTime.parse(json['date']);
    if (json['executors'].isNotEmpty) {
      executors = json['executors'].map<User>((user) => User.fromJson(user)).toList();
    }
    all_task_count = json['all_task_count'];
    completed_tasks_count = json['completed_tasks_count'];
    pause_tasks_count = json['pause_tasks_count'];
    in_work_tasks_count = json['in_work_tasks_count'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date_time_create': date_time_create,
        'author_name': author_name,
        'operation_name': operation_name,
        'description': description,
        'row_text': row_text,
        'rows': rows,
        'greenhouse_name': greenhouse_name,
        'date': date,
        'executors': executors.map((e) => e.toJson()).toList(),
        'all_task_count': all_task_count,
        'completed_tasks_count': completed_tasks_count,
        'pause_tasks_count': pause_tasks_count,
        'in_work_tasks_count': in_work_tasks_count,
      };
}

class Task {
  late int id;
  DateTime? date_time_start;
  DateTime? date_time_end;
  late String greenhouse;
  late int? row;
  late int? row_name;
  late String operation_name;
  late String? unit_name;
  late String? actual_type_action;
  late String? last_action_user_name;
  late String? last_action_author_name;
  late String? category_name;
  late User? fixed_user;
  late User? responsible_executor;
  int quantity = 0;
  double coefficient = 1;

  bool piece = false;
  bool task_rows = false;
  bool in_single_volume = false;
  bool parallel = false;

  Task();

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date_time_start = DateTime.tryParse(json['date_time_start'] ?? '')?.toLocal();
    date_time_end = DateTime.tryParse(json['date_time_end'] ?? '')?.toLocal();
    greenhouse = json['greenhouse'];
    row = json['row'];
    row_name = json['row_name'];
    operation_name = json['operation_name'];
    unit_name = json['unit_name'];
    actual_type_action = json['actual_type_action'];
    last_action_user_name = json['last_action_user_name'];
    last_action_author_name = json['last_action_author_name'];
    category_name = json['category_name'];
    fixed_user = json['fixed_user'] != null ? User.fromJson(json['fixed_user']) : null;
    responsible_executor = json['responsible_executor'] != null ? User.fromJson(json['responsible_executor']) : null;
    quantity = json['quantity'] ?? 0;
    coefficient = json['coefficient'] ?? 0;
    piece = json['piece'];
    task_rows = json['task_rows'];
    in_single_volume = json['in_single_volume'];
    parallel = json['parallel'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date_time_start': date_time_start,
        'date_time_end': date_time_end,
        "greenhouse": greenhouse,
        'row': row,
        'row_name': row_name,
        'operation_name': operation_name,
        "actual_type_action": actual_type_action,
        "last_action_user_name": last_action_user_name,
        "last_action_author_name": last_action_author_name,
        "category_name": category_name,
        "fixed_user": fixed_user?.toJson(),
        "responsible_executor": responsible_executor?.toJson(),
        "quantity": quantity,
        "coefficient": coefficient,
        "piece": piece,
        "task_rows": task_rows,
        "in_single_volume": in_single_volume,
        "parallel": parallel,
      };
}

class Greenhouse {
  late int id;
  late String name;
  late String? department_name;
  late int? department;
  late int? manager;
  late String? card_uniq_name;

  Greenhouse();

  Greenhouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    department_name = json['department_name'];
    department = json['department'];
    manager = json['manager'];
    card_uniq_name = json['card_uniq_name'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "department_name": department_name,
        "department": department,
        "manager": manager,
        "card_uniq_name": card_uniq_name,
      };
}

class GreenhouseRow {
  late int id;
  late int number;
  late String? unic_name;
  late String? card_uniq_name;

  GreenhouseRow();

  GreenhouseRow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    unic_name = json['unic_name'];
    card_uniq_name = json['card_uniq_name'];
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "number": number, "unic_name": unic_name, "card_uniq_name": card_uniq_name};
}

// Map<String, String> choiceStatus = {
//   'accept waiting': 'Ожидает принятия',
//   'accepted': 'В работе',
//   'paused': 'На паузе',
//   'done': 'Выполнена',
// };
