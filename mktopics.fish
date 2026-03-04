# Maak lokale kafka topics aan o.b.v. txt file
function mktopics
    set KAFKA_CONN "localhost:9092"
    set CONTAINER_NAME "kafka"
    set TOPIC_FILE $argv[1]

    if not test -f "$TOPIC_FILE"
        echo "Usage: mktopics <./pad/naar/topics.txt>"
        return 1
    end

    set EXISTING_TOPICS (docker exec -i $CONTAINER_NAME kafka-topics.sh \
        --bootstrap-server $KAFKA_CONN \
        --list)

    for topic in (string trim (cat $TOPIC_FILE))
        if test -z "$topic"
            continue
        end

        if not contains -- $topic $EXISTING_TOPICS
            echo "Topic '$topic' wordt aangemaakt..."

            docker exec -i $CONTAINER_NAME kafka-topics \
                --bootstrap-server $KAFKA_CONN \
                --create \
                --if-not-exists \
                --topic $topic \
                --partitions 1 \
                --replication-factor 1

            if test $status -eq 0
                echo "Topic '$topic' aangemaakt."
            else
                echo "Fout bij aanmaken van '$topic'"
            end
        end
    end

    echo "Klaar."
end

