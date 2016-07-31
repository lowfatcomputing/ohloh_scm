module OhlohScm::Adapters
	class DarcsAdapter < AbstractAdapter
		def exist?
			begin
				!!(head_token)
			rescue
				logger.debug { $! }
				false
			end
		end

		def ls_tree(token)
			run("cd '#{path}' && darcs show files --no-pending -h '#{token}'").split("\n")
		end

		def export(dest_dir, token=nil)
			p = token ? " -h '#{token}'" : ""
			run("cd '#{path}' && darcs dist#{p} && mv darcs.tar.gz '#{dest_dir}'")
		end
	end
end