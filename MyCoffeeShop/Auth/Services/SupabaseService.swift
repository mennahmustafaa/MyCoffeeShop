import Foundation
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
    
    /// Sign up a new user - throws error if user already exists
    func signUp(email: String, password: String) async throws {
        print("SupabaseService: signUp called")
        let response = try await client.auth.signUp(email: email, password: password)
        
        // Check if the user already exists
        // When email confirmation is disabled and user exists, Supabase returns a user with empty identities
        let user = response.user
        if user.identities?.isEmpty == true {
            print("SupabaseService: User already exists")
            throw AuthError.userAlreadyExists
        }
        
        print("SupabaseService: signUp completed")
    }
    
    /// Custom error for auth operations
    enum AuthError: LocalizedError {
        case userAlreadyExists
        
        var errorDescription: String? {
            switch self {
            case .userAlreadyExists:
                return "This email is already registered. Please login instead."
            }
        }
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
    
    func updateUser(password: String) async throws {
        let attributes = UserAttributes(password: password)
        _ = try await client.auth.update(user: attributes)
    }
    
    func currentUser() async throws -> User? {
        return client.auth.currentUser
    }
    
    // MARK: - Deep Link Handling
    
    /// Handle the deep link URL from email confirmation
    func handleDeepLink(url: URL) async throws {
        try await client.auth.session(from: url)
    }
}
