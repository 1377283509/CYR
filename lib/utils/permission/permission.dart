// 修改权限
enum PermissionType {
  // 手环信息
  BANGLE,
  // 诊断结果
  VISIT_RESULT,
  // 主治医生
  DOCTOR,
  // 生命体征
  VITAL_SIGNS,
  // 心电图
  ECG,
  // 化验检查
  LABORATORY_EXAMINATION,
  // CT
  CT,
  // 二线
  SECOND_LINE_DOCTOR,
  ASPECT,
  CI
}

// 科室 权限表
Map<PermissionType, String> departmentPermission = {
  PermissionType.BANGLE: "急救中心",
  PermissionType.VISIT_RESULT: "急诊科",
  PermissionType.DOCTOR: "急诊科",
  PermissionType.VITAL_SIGNS: "急诊科",
  PermissionType.ECG: "急诊科",
  PermissionType.LABORATORY_EXAMINATION: "急诊科",
  PermissionType.CT: "影像科",
  PermissionType.SECOND_LINE_DOCTOR: "神经内科",
  PermissionType.ASPECT: "神经内科",
  PermissionType.CI: "神经内科"
};

bool permissionHandler(PermissionType type, String department) => departmentPermission[type] == department;
