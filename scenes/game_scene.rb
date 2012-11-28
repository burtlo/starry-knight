module Metro
  class Scene

    def threads
      @threads ||= {}
    end

    def background(thread_name=:background)

      threads[thread_name] = Thread.new do
        # sleep 5
        # puts "THREAD IS ALIVE!"
        puts "#{self}"
        yield if block_given?
        # sleep 5
      end


    end

    def transition_to(scene_or_scene_name,options = {})
      check_for_outstanding_threads

      if scene_has_outstanding_threads? and not options[:force]
        background :worker do
          wait_for_outstanding_threads do
            after 1.tick do
              transition_to scene_or_scene_name, force: true
            end
          end
        end

        return
      end

      new_scene = Scenes.generate(scene_or_scene_name,options)
      _prepare_transition(new_scene)
      window.scene = new_scene
    end

    def scene_has_outstanding_threads?
      threads.find { |name,thread| thread.alive? unless name == :worker }
    end

    def check_for_outstanding_threads
      threads.each { |name,thread| log.debug "Thread [#{name}] is alive? #{thread.alive?}"}
    end

    def wait_for_outstanding_threads
      log.debug "Waiting for unfinished threads"
      threads.each { |name,thread| thread.join unless name == :worker }
      log.debug "Finished waiting for threads"
      after 1.tick do
        yield if block_given?
      end
    end


  end
end

class GameScene < Metro::Scene

  event :on_up, KbR do |event|
    if event.control?
      log.debug "Initiating a RELOAD"

      background do
        if Metro.game_has_valid_code?
          after(1.tick) { Metro.reload! ; transition_to(scene_name) }
        end
      end

    end
  end

  event :on_up, KbE do |event|
    transition_to scene_name, with: :edit
  end

  def fade_in_and_out(name)
    animate name, to: { alpha: 255, background_color_alpha: 20 }, interval: 2.seconds do
      after 1.second do
        animate name, to: { alpha: 0, background_color_alpha: 0 }, interval: 1.second do
          yield if block_given?
        end
      end
    end
  end

end

