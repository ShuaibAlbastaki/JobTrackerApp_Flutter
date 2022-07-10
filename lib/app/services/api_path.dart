/// This class provides hard-coded paths to the Database location on Cloud Firestore collections.
class APIPath {
  static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  static String jobs(String uid) => 'users/$uid/jobs';
}
