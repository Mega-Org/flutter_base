part of app_pagination;

// enum PaginatedStatusEnum {
//   firstPageLoading,
//   firstPageError,
//   newPageLoading,
//   newPageError,
//   completed,
//   noItemsFound,
// }

// extension PaginatedStatusEnumExtension<K, T> on PaginationState<K, T> {
//   PaginatedStatusEnum get status {
//     if (_isFirstPageLoading) {
//       return PaginatedStatusEnum.firstPageLoading;
//     } else if (_isFirstPageFailure) {
//       return PaginatedStatusEnum.firstPageError;
//     } else if (_isNoItemsFound) {
//       return PaginatedStatusEnum.noItemsFound;
//     } else if (_isLoadMoreLoading) {
//       return PaginatedStatusEnum.newPageLoading;
//     } else if (_isLoadMoreFailure) {
//       return PaginatedStatusEnum.newPageError;
//     } else if (_isCompleted) {
//       return PaginatedStatusEnum.completed;
//     } else {
//       return PaginatedStatusEnum.firstPageLoading;
//     }
//   }
// }
