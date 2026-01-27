import Supabase

class SupabaseService {
    static let shared = SupabaseService()
    
    private let client = SupabaseClient(
        supabaseURL: SupabaseConfig.supabaseURL,
        supabaseKey: SupabaseConfig.supabaseKey,
        options: SupabaseClientOptions(
            auth: .init(emitLocalSessionAsInitialSession: true)
        )
    )
    
    private init() {}
    
    // MARK: - Auth Methods
    
    func signUp(email: String, password: String) async throws {
        print("SupabaseService: signUp called")
        _ = try await client.auth.signUp(email: email, password: password)
        print("SupabaseService: signUp completed")
    }
    
    func signIn(email: String, password: String) async throws {
        _ = try await client.auth.signIn(email: email, password: password)
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func resetPassword(email: String) async throws {
        try await client.auth.resetPasswordForEmail(email)
    }
    
    func currentUser() async throws -> User? {
        return client.auth.currentUser
    }
}
